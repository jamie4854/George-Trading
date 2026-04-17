# Routine 2 — Market Open Scan
**Scheduled:** 14:30 BST (09:30 ET, US market open)
**Market status at runtime:** open (first minutes of US session)

## Purpose
How has the market opened, and do any pre-market candidates warrant scoring and a trade today?

## Read on Start
- `TRADING-STRATEGY.MD` — strategy and guardrails (required before any trade)
- `daily-logs/research/<DD-MM-YY>.md` — today's pre-market brief and watchlist from Routine 1
- `daily-logs/portfolio/<last>.md` — most recent portfolio snapshot
- `daily-logs/scores/<last>.md` — most recent scores (context for repeat candidates)

## Tasks (in order)
1. Read the strategy document — confirm per-position cap (£1,000), drawdown cap (20–25%), and hard excludes.
2. Read today's pre-market brief and watchlist from Routine 1.
3. Pull live account + position state from Alpaca (cash, positions, unrealised P&L).
4. Compare open prints against yesterday's close for every held position; flag anything moving >3%.
5. Identify which pre-market candidates are viable for scoring today based on opening action and any news since 07:00 BST.
6. Score selected candidates against the weighted fundamentals framework in `TRADING-STRATEGY.MD`.
7. **Submit scores to the n8n conviction webhook** — this must happen before any trade is placed. No trade without a score.
8. Receive conviction levels back from n8n; size positions per conviction, capped at £1,000 per stock.
9. Check portfolio drawdown — if at 20–25% from peak, **halt all new capital deployment** and log the halt.
10. Place trades via the Alpaca paper API for any approved conviction.
11. Log every score submitted, every trade executed, and take a fresh portfolio snapshot.

## Write on Completion
- `daily-logs/scores/<DD-MM-YY>.md` — scores submitted today (ticker, rubric breakdown, n8n conviction returned)
- `daily-logs/trades/<DD-MM-YY>.md` — trades placed today (ticker, side, size, £ deployed, Alpaca order id)
- `daily-logs/portfolio/<DD-MM-YY>.md` — post-open portfolio snapshot

## Notifications
- **Email:** trade confirmations and an open-scan summary (positions checked, candidates scored, trades placed, drawdown status).
- **Silent log:** raw Perplexity notes, n8n request/response payloads, Alpaca API responses.

## GitHub Commit
Commit the scores, trades, and portfolio files at the end of the routine.

Suggested commit message:
```
feat(routine-2): market open scan <DD-MM-YY>
```
