# Routine 5 — Pre-Close Scan
**Scheduled:** 20:30 BST (≈15:30 ET, 30 minutes before US close)
**Market status at runtime:** open (final 30 minutes)

## Purpose
Any last conviction-worthy move before the close — and do not chase.

## Read on Start
- `TRADING-STRATEGY.MD` — strategy and guardrails (required before any trade)
- `daily-logs/research/<DD-MM-YY>.md`
- `daily-logs/scores/<DD-MM-YY>.md`
- `daily-logs/trades/<DD-MM-YY>.md`
- `daily-logs/portfolio/<DD-MM-YY>.md`

## Tasks (in order)
1. Read the strategy document, paying attention to the "no chasing" discipline.
2. Read all of today's logs.
3. Use Perplexity to pull any late-breaking news and the current state of the session.
4. Do a final pass over every held position for thesis breaks.
5. Identify any final candidates for the day; be strict — if conviction is not already clear, **do not score and do not trade**.
6. For any candidate that does pass the conviction bar, score it against the strategy rubric.
7. **Submit scores to the n8n conviction webhook** before any trade.
8. Place final trades only if fully justified; respect the £1,000 per-stock cap and the 20–25% drawdown halt.
9. Append to today's logs and refresh the portfolio snapshot.

## Write on Completion
- Append to `daily-logs/scores/<DD-MM-YY>.md`
- Append to `daily-logs/trades/<DD-MM-YY>.md`
- Update `daily-logs/portfolio/<DD-MM-YY>.md`
- Append late-session notes and a short "decisions not taken" log to `daily-logs/research/<DD-MM-YY>.md`

## Notifications
- **Email:** any final trades, any thesis breaks, and a one-line "pre-close status" (positions held, cash, drawdown).
- **Silent log:** Perplexity notes, n8n payloads, Alpaca responses, reasoning for any deferrals.

## GitHub Commit
Commit the updated scores, trades, portfolio, and research files.

Suggested commit message:
```
feat(routine-5): pre-close scan <DD-MM-YY>
```
