# Routine 7 — Overnight Research
**Scheduled:** 23:00 BST
**Market status at runtime:** closed (no trades permitted)

## Purpose
Deep, unhurried research — build the best possible watchlist for tomorrow. On Fridays, also produce the weekly performance report vs the S&P 500.

## Read on Start
- `TRADING-STRATEGY.MD` — strategy and scoring rubric
- `daily-logs/reports/<DD-MM-YY>.md` — today's daily summary from Routine 6
- `daily-logs/portfolio/<DD-MM-YY>.md` — end-of-day portfolio snapshot
- `daily-logs/research/` — the last few nights of watchlists (to avoid re-researching recently rejected names)
- If Friday: `daily-logs/reports/` (this week's daily summaries) and `daily-logs/portfolio/` (this week's snapshots)

## Tasks (in order)
1. Read the strategy document.
2. Read today's end-of-day report and portfolio snapshot.
3. Use Perplexity for deep research:
   - candidate stocks fitting the fundamentals-first rubric (tech conviction, but diversified)
   - earnings released today, and earnings expected tomorrow, for held positions and candidates
   - macro trends (rates, inflation, commodities, FX, geopolitics)
   - sector rotation and flows over the past week
4. For each candidate, capture: what the business does, why it fits the rubric, key risks, and a preliminary score breakdown. **Do not submit to n8n, do not trade** — market is closed and this routine is research only.
5. Rank the candidates and produce tomorrow's watchlist.
6. Note any held position that should be reviewed early in Routine 1 (e.g. earnings overnight, material news).
7. **If today is Friday:**
   a. Pull weekly portfolio performance (equity start → end of week).
   b. Pull S&P 500 weekly performance over the same window.
   c. Compute relative performance (alpha), weekly drawdown, biggest contributors and detractors.
   d. Write the weekly report.
   e. Send the weekly performance email.

## Write on Completion
- `daily-logs/research/<DD-MM-YY>.md` — overnight research notes and tomorrow's ranked watchlist
- If Friday: `daily-logs/reports/weekly-<WW>-<YYYY>.md` — weekly performance report vs S&P 500

## Notifications
- **Email (Friday only):** "George — Weekly Performance <WW>/<YYYY>" — portfolio vs S&P 500, alpha, drawdown, biggest movers, narrative.
- **Silent log:** full Perplexity query log, candidate scoring notes, rejected candidates with reasons.

## GitHub Commit
Commit the research file (and the weekly report on Fridays).

Suggested commit message (Mon–Thu):
```
chore(routine-7): overnight research <DD-MM-YY>
```

Suggested commit message (Friday):
```
chore(routine-7): overnight research + weekly report <DD-MM-YY>
```
