# Routine 3 — Mid-Morning Scan
**Scheduled:** 16:30 BST (≈11:30 ET)
**Market status at runtime:** open

## Purpose
Post-open volatility has settled — is there fresh news that changes any decision, and does any candidate or held position need action now?

## Read on Start
- `TRADING-STRATEGY.MD` — strategy and guardrails (required before any trade)
- `daily-logs/research/<DD-MM-YY>.md` — today's pre-market brief
- `daily-logs/scores/<DD-MM-YY>.md` — scores submitted at open
- `daily-logs/trades/<DD-MM-YY>.md` — trades placed at open
- `daily-logs/portfolio/<DD-MM-YY>.md` — post-open portfolio snapshot

## Tasks (in order)
1. Read the strategy document.
2. Read today's earlier logs (research, scores, trades, portfolio).
3. Use Perplexity to pull news that has broken since the US open:
   - company-specific news on every held position
   - news on candidates scored or deferred at open
   - fresh macro/sector developments
4. For every held position, ask explicitly: has the investment thesis broken? If yes, flag it.
5. Reassess any candidates from Routine 2 that George chose not to act on — has the picture clarified?
6. Score any new candidates that now meet the threshold.
7. **Submit any new scores to the n8n conviction webhook** before any trade.
8. Place trades only where conviction is clear; respect the £1,000 per-stock cap.
9. Re-check portfolio drawdown — halt new capital if at 20–25%.
10. Append to today's logs and refresh the portfolio snapshot.

## Write on Completion
- Append to `daily-logs/scores/<DD-MM-YY>.md`
- Append to `daily-logs/trades/<DD-MM-YY>.md`
- Update `daily-logs/portfolio/<DD-MM-YY>.md`
- Append thesis-break flags to `daily-logs/research/<DD-MM-YY>.md`

## Notifications
- **Email:** any trades executed, any thesis breaks flagged, any drawdown warnings.
- **Silent log:** Perplexity notes, n8n payloads, Alpaca responses, and any reasoning for deferrals.

## GitHub Commit
Commit the updated scores, trades, portfolio, and research files.

Suggested commit message:
```
feat(routine-3): mid-morning scan <DD-MM-YY>
```
