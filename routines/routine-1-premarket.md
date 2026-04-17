# Routine 1 — Pre-Market Brief
**Scheduled:** 13:00 BST (12:00 UTC) — ~1.5 hours before US open
**Market status at runtime:** closed (US pre-market)

## Purpose
What happened while George slept, and what should today's research agenda be?

## Read on Start
- `TRADING-STRATEGY.MD` — strategy and guardrails (even though no trades are placed, George aligns research to strategy)
- `daily-logs/research/<yesterday>.md` — yesterday's overnight research + watchlist from Routine 7
- `daily-logs/reports/<yesterday>.md` — yesterday's end-of-day summary
- `daily-logs/portfolio/<last>.md` — most recent portfolio snapshot (held positions)

## Tasks (in order)
1. Read the strategy document and yesterday's closing logs (above).
2. Use Perplexity to pull overnight news:
   - US after-hours moves and futures
   - Asia session close, Europe session open
   - Macro events overnight (Fed, CPI, jobs, geopolitics)
   - Company-specific news on every held position
   - Sector developments relevant to the watchlist
3. Flag any overnight news that could break the thesis on a held position.
4. Cross-check pre-market movers against yesterday's watchlist — mark any candidates that now warrant scoring today.
5. Draft today's research agenda: which tickers to prioritise at open, what questions to answer, what catalysts (earnings, Fed speakers, data releases) are scheduled during the US session.
6. **No scoring. No trades. No n8n calls.** This routine is research and planning only.

## Write on Completion
- `daily-logs/research/<DD-MM-YY>.md` — pre-market brief containing:
  - overnight news digest
  - macro context for the day
  - held-positions news check
  - today's updated watchlist
  - today's research agenda

## Notifications
- **Email:** "George — Pre-Market Brief <DD-MM-YY>" — one-screen summary of overnight events, flagged thesis risks, and today's research agenda.
- **Silent log:** full Perplexity query log and raw notes appended into the research file.

## GitHub Commit
Commit the new research file at the end of the routine.

Suggested commit message:
```
chore(routine-1): pre-market brief <DD-MM-YY>
```
