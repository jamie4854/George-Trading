#!/usr/bin/env bash
# test-env.sh — validate all George environment variables.
# Tests: presence, format, and live connectivity for each service.
# Usage: bash scripts/test-env.sh

set -uo pipefail   # note: no -e so ((counter++)) when counter=0 doesn't abort

PASS=0
FAIL=0
WARN=0

green()  { printf '\033[0;32m[PASS]\033[0m %s\n' "$*"; }
red()    { printf '\033[0;31m[FAIL]\033[0m %s\n' "$*"; }
yellow() { printf '\033[0;33m[WARN]\033[0m %s\n' "$*"; }

pass() { green "$1"; PASS=$((PASS + 1)); }
fail() { red   "$1"; FAIL=$((FAIL + 1)); }
warn() { yellow "$1"; WARN=$((WARN + 1)); }

require_var() {
  local name="$1"
  local val="${!name:-}"
  if [[ -z "$val" ]]; then
    fail "${name} is not set"
    return 1
  fi
  pass "${name} is set"
  return 0
}

# Run curl and return only the HTTP status code (3 digits).
# Never errors even if the connection fails — returns 000 on network failure.
http_status() {
  local status
  status=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "$@" 2>/dev/null) || true
  # curl outputs "000" on connection failure; strip any trailing newlines
  printf '%s' "${status:-000}"
}

echo ""
echo "========================================"
echo "  George — Environment Variable Tests"
echo "========================================"
echo ""

# ── 1. Alpaca ─────────────────────────────────────────────────────────────────
echo "── Alpaca ────────────────────────────────"

require_var ALPACA_API_KEY    || true
require_var ALPACA_SECRET_KEY || true
require_var ALPACA_BASE_URL   || true

# Format check: base URL should end in /v2
if [[ "${ALPACA_BASE_URL:-}" =~ ^https?://.+/v2$ ]]; then
  pass "ALPACA_BASE_URL format looks correct (ends in /v2)"
else
  fail "ALPACA_BASE_URL format unexpected: ${ALPACA_BASE_URL:-<unset>}"
fi

# Live connectivity: GET /account
echo "  → Testing Alpaca API connectivity..."
ALPACA_STATUS=$(http_status \
  -H "APCA-API-KEY-ID: ${ALPACA_API_KEY:-}" \
  -H "APCA-API-SECRET-KEY: ${ALPACA_SECRET_KEY:-}" \
  "${ALPACA_BASE_URL:-https://paper-api.alpaca.markets/v2}/account")

if [[ "$ALPACA_STATUS" == "200" ]]; then
  pass "Alpaca API /account → HTTP 200 (authenticated)"
elif [[ "$ALPACA_STATUS" == "403" ]]; then
  fail "Alpaca API /account → HTTP 403 (invalid credentials)"
elif [[ "$ALPACA_STATUS" == "000" ]]; then
  fail "Alpaca API /account → connection failed (network error or timeout)"
else
  fail "Alpaca API /account → unexpected HTTP ${ALPACA_STATUS}"
fi

echo ""

# ── 2. n8n Webhook ────────────────────────────────────────────────────────────
echo "── n8n Webhook ───────────────────────────"

require_var N8N_WEBHOOK_URL  || true
require_var N8N_HTTP_METHOD  || true

# N8N_HTTP_METHOD should be GET or POST
if [[ "${N8N_HTTP_METHOD:-}" =~ ^(GET|POST)$ ]]; then
  pass "N8N_HTTP_METHOD is valid (${N8N_HTTP_METHOD})"
else
  fail "N8N_HTTP_METHOD is not GET or POST: ${N8N_HTTP_METHOD:-<unset>}"
fi

# Live connectivity: send a test probe using the configured method
echo "  → Testing n8n webhook connectivity..."
N8N_STATUS=$(http_status \
  -X "${N8N_HTTP_METHOD:-GET}" \
  "${N8N_WEBHOOK_URL:-}?test=1&source=test-env")

if [[ "$N8N_STATUS" =~ ^2 ]]; then
  pass "n8n webhook → HTTP ${N8N_STATUS} (reachable)"
elif [[ "$N8N_STATUS" == "000" ]]; then
  fail "n8n webhook → connection failed (network error or timeout)"
else
  # 4xx/5xx from a probe with missing required params may be expected
  warn "n8n webhook → HTTP ${N8N_STATUS} (may be expected for a probe; verify manually)"
fi

echo ""

# ── 3. SMTP / Email ───────────────────────────────────────────────────────────
echo "── SMTP / Email ──────────────────────────"

require_var SMTP_HOST     || true
require_var SMTP_PORT     || true
require_var SMTP_USER     || true
require_var SMTP_PASSWORD || true

require_var GEORGE_FROM_EMAIL         || true
require_var GEORGE_NOTIFICATION_EMAIL || true

# Port should be a number
if [[ "${SMTP_PORT:-}" =~ ^[0-9]+$ ]]; then
  pass "SMTP_PORT is numeric (${SMTP_PORT})"
else
  fail "SMTP_PORT is not a valid number: ${SMTP_PORT:-<unset>}"
fi

# Common SMTP ports
if [[ "${SMTP_PORT:-}" =~ ^(25|465|587|2525)$ ]]; then
  pass "SMTP_PORT is a known mail port (${SMTP_PORT})"
else
  warn "SMTP_PORT ${SMTP_PORT:-} is non-standard — double-check"
fi

# Email format sanity checks
for var in GEORGE_FROM_EMAIL GEORGE_NOTIFICATION_EMAIL SMTP_USER NOTIFICATION_EMAIL; do
  val="${!var:-}"
  if [[ -z "$val" ]]; then continue; fi
  if [[ "$val" =~ ^[^@]+@[^@]+\.[^@]+$ ]]; then
    pass "${var} looks like a valid email (${val})"
  else
    fail "${var} does not look like a valid email: ${val}"
  fi
done

# TCP reachability: can we connect to the SMTP host on the configured port?
echo "  → Testing TCP connection to ${SMTP_HOST:-}:${SMTP_PORT:-}..."
if timeout 10 bash -c "echo >/dev/tcp/${SMTP_HOST:-smtp.gmail.com}/${SMTP_PORT:-587}" 2>/dev/null; then
  pass "SMTP TCP connection to ${SMTP_HOST}:${SMTP_PORT} succeeded"
else
  fail "SMTP TCP connection to ${SMTP_HOST:-}:${SMTP_PORT:-} failed"
fi

echo ""

# ── 4. GEORGE_* Configuration ─────────────────────────────────────────────────
echo "── George Configuration ──────────────────"

require_var GEORGE_STARTING_VALUE        || true
require_var GEORGE_DEFAULT_POSITION_SIZE || true
require_var GEORGE_MAX_POSITION_SIZE     || true
require_var GEORGE_MIN_POSITIONS         || true
require_var GEORGE_MAX_POSITIONS         || true
require_var GEORGE_DRAWDOWN_CAP          || true

# All should be positive integers
for var in GEORGE_STARTING_VALUE GEORGE_DEFAULT_POSITION_SIZE GEORGE_MAX_POSITION_SIZE \
           GEORGE_MIN_POSITIONS GEORGE_MAX_POSITIONS GEORGE_DRAWDOWN_CAP; do
  val="${!var:-}"
  if [[ "$val" =~ ^[0-9]+$ ]]; then
    pass "${var} is a positive integer (${val})"
  else
    fail "${var} is not a positive integer: ${val:-<unset>}"
  fi
done

# Logic checks
START="${GEORGE_STARTING_VALUE:-0}"
DEFAULT_POS="${GEORGE_DEFAULT_POSITION_SIZE:-0}"
MAX_POS="${GEORGE_MAX_POSITION_SIZE:-0}"
MIN_POSITIONS="${GEORGE_MIN_POSITIONS:-0}"
MAX_POSITIONS="${GEORGE_MAX_POSITIONS:-0}"
DRAWDOWN="${GEORGE_DRAWDOWN_CAP:-0}"

if [[ "$DEFAULT_POS" -le "$MAX_POS" ]]; then
  pass "GEORGE_DEFAULT_POSITION_SIZE (${DEFAULT_POS}) ≤ GEORGE_MAX_POSITION_SIZE (${MAX_POS})"
else
  fail "GEORGE_DEFAULT_POSITION_SIZE (${DEFAULT_POS}) must be ≤ GEORGE_MAX_POSITION_SIZE (${MAX_POS})"
fi

if [[ "$MIN_POSITIONS" -lt "$MAX_POSITIONS" ]]; then
  pass "GEORGE_MIN_POSITIONS (${MIN_POSITIONS}) < GEORGE_MAX_POSITIONS (${MAX_POSITIONS})"
else
  fail "GEORGE_MIN_POSITIONS (${MIN_POSITIONS}) must be < GEORGE_MAX_POSITIONS (${MAX_POSITIONS})"
fi

if [[ "$DRAWDOWN" -gt 0 && "$DRAWDOWN" -le 100 ]]; then
  pass "GEORGE_DRAWDOWN_CAP (${DRAWDOWN}%) is in range (1–100)"
else
  fail "GEORGE_DRAWDOWN_CAP (${DRAWDOWN}) is out of range"
fi

if [[ "$MAX_POS" -le "$START" ]]; then
  pass "GEORGE_MAX_POSITION_SIZE (${MAX_POS}) ≤ GEORGE_STARTING_VALUE (${START})"
else
  fail "GEORGE_MAX_POSITION_SIZE (${MAX_POS}) exceeds GEORGE_STARTING_VALUE (${START}) — positions cannot be funded"
fi

echo ""
echo "========================================"
printf "  Results: %s passed, %s failed, %s warnings\n" "$PASS" "$FAIL" "$WARN"
echo "========================================"
echo ""

if [[ "$FAIL" -gt 0 ]]; then
  exit 1
fi
