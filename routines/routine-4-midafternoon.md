# Routine 4 — Mid-Afternoon Scan
**Scheduled:** 18:30 BST (≈13:30 ET)
**Market status at runtime:** open (midday calm)

## Purpose
Are any sector or macro developments since mid-morning worth acting on, and is the portfolio still clear of the drawdown guardrails?

## Read on Start
- `TRADING-STRATEGY.MD` — strategy and guardrails (required before any trade)
- `daily-logs/research/<DD-MM-YY>.md`
- `daily-logs/scores/<DD-MM-YY>.md`
- `daily-logs/trades/<DD-MM-YY>.md`
- `daily-logs/portfolio/<DD-MM-YY>.md`

## Tasks (in order)
1. Read the strategy document.
2. Read all of today's logs so far.
3. Use Perplexity to pull sector and macro news from the past ~2 hours (Fed speakers, data releases, sector rotation, cross-asset moves).
4. Identify any new research candidates that have emerged during the day.
5. Revisit every held position: price action vs today's open, P&L vs entry, any fresh headlines — flag any thesis breaks.
6. **Portfolio drawdown guardrail check** — calculate drawdown from peak. If approaching 20%, raise a warning; if at 20–25%, halt all new capital deployment.
7. Score any qualifying candidates; **submit scores to the n8n conviction webhook** before any trade.
8. Place trades only if conviction justifies it, always respecting the £1,000 per-stock cap.
9. Append to today's logs and refresh the portfolio snapshot.

## Write on Completion
- Append to `daily-logs/scores/<DD-MM-YY>.md`
- Append to `daily-logs/trades/<DD-MM-YY>.md`
- Update `daily-logs/portfolio/<DD-MM-YY>.md`
- Append sector/macro notes and any thesis-break flags to `daily-logs/research/<DD-MM-YY>.md`

## Notifications
- **Email:** drawdown warning (if near threshold), any trades executed, any thesis breaks flagged.
- **Silent log:** Perplexity notes, n8n payloads, Alpaca responses, drawdown calculation.

## GitHub Commit
Commit the updated scores, trades, portfolio, and research files.

Suggested commit message:
```
feat(routine-4): mid-afternoon scan <DD-MM-YY>
```
