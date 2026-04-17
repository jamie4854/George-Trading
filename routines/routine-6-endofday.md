# Routine 6 — End of Day
**Scheduled:** 21:15 BST (≈16:15 ET, 15 minutes after US close)
**Market status at runtime:** closed

## Purpose
Close the day properly — snapshot, reconcile, report, persist. This is the day's most important routine for record-keeping.

## Read on Start
- `TRADING-STRATEGY.MD` — strategy (context for the daily narrative)
- `daily-logs/research/<DD-MM-YY>.md`
- `daily-logs/scores/<DD-MM-YY>.md`
- `daily-logs/trades/<DD-MM-YY>.md`
- `daily-logs/portfolio/<DD-MM-YY>.md` (intraday state)
- `daily-logs/portfolio/<yesterday>.md` (for day-over-day P&L)
- `daily-logs/reports/<yesterday>.md` (continuity)

## Tasks (in order)
1. Pull the final portfolio state from Alpaca (cash, positions, unrealised and realised P&L, total equity).
2. Reconcile today's executed trades against `daily-logs/trades/<DD-MM-YY>.md` — flag any mismatches.
3. Calculate the day:
   - day P&L in £ and %
   - portfolio value vs previous close
   - current drawdown from all-time peak
   - S&P 500 comparison for the day (benchmark)
4. Compile the daily summary:
   - trades executed (with rationale)
   - scores submitted (with conviction returned)
   - held positions status (price, P&L, any thesis notes)
   - drawdown status vs 20–25% guardrail
   - thesis breaks flagged today
   - open questions to carry into Routine 7 overnight research
5. Write the final portfolio snapshot and the daily report.
6. Send the daily summary email.
7. Commit every log produced today to GitHub.

## Write on Completion
- `daily-logs/portfolio/<DD-MM-YY>.md` — final end-of-day snapshot (overwrites intraday version)
- `daily-logs/reports/<DD-MM-YY>.md` — full daily summary

## Notifications
- **Email:** "George — Daily Summary <DD-MM-YY>" — trades, P&L, portfolio state, benchmark comparison, drawdown status, flagged thesis breaks.
- **Silent log:** Alpaca reconciliation details, any mismatches between intraday logs and final broker state.

## GitHub Commit
Commit all of today's files in a single end-of-day commit:
- `daily-logs/research/<DD-MM-YY>.md`
- `daily-logs/scores/<DD-MM-YY>.md`
- `daily-logs/trades/<DD-MM-YY>.md`
- `daily-logs/portfolio/<DD-MM-YY>.md`
- `daily-logs/reports/<DD-MM-YY>.md`

Suggested commit message:
```
feat(routine-6): end of day <DD-MM-YY>
```
