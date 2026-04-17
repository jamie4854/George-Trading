# George 🤖
### Autonomous AI Trading Agent

> A long-term, fundamentals-driven trading agent built on Claude Code, Alpaca, and n8n — designed to beat the S&P 500 over a 5-year horizon.

---

## What is George?

George is an autonomous AI investment agent that runs 24/7 via Claude Code routines. He researches stocks, scores them against a weighted fundamentals framework, submits scores to an external conviction engine, and executes trades via the Alpaca paper trading API — all without human intervention.

He is not a day trader. He does not chase trends. He is a patient, fundamentals-first investor with a 5-year time horizon and a single benchmark to beat: the S&P 500.

---

## Project Status

| Stage | Status |
|-------|--------|
| Strategy definition | ✅ Complete |
| Project scaffolding (CLAUDE.md) | 🔲 In progress |
| n8n conviction scoring webhook | 🔲 Pending |
| Alpaca paper trading integration | 🔲 Pending |
| Notification pipeline (email) | 🔲 Pending |
| Live paper trading | 🔲 Pending |
| Real money deployment | 🔲 Future |

---

## How George Works

```
George wakes up on a routine
        │
        ▼
Reads memory files (portfolio state, strategy, logs)
        │
        ▼
Researches market — macro context, earnings, news
        │
        ▼
Identifies candidate stocks independently
        │
        ▼
Scores each candidate across 5 factors (1–10 each)
        │
        ▼
Submits raw scores to n8n webhook
        │
        ▼
Receives position size budget back (formula is hidden from George)
        │
        ▼
Decides exact investment amount (±£200 discretion)
        │
        ▼
Executes trade via Alpaca API
        │
        ▼
Logs everything, sends notifications, commits state to GitHub
```

---

## The Conviction Scoring System

George evaluates every candidate stock across five weighted factors:

| Factor | Weight |
|--------|--------|
| Earnings & Financial Trend | 28.57% |
| Macro Context | 22.86% |
| News & Sentiment | 20.00% |
| Valuation (P/E) | 17.14% |
| Competitive Moat | 11.43% |

George submits his five raw scores (1–10) to an **n8n webhook**. The webhook calculates the conviction score using a weighted formula **that George never sees** — preventing him from gaming his own scores. George receives back only a **position size budget in pounds**.

Scores below 5.0 result in no investment. Scores above 9.5 unlock the maximum £1,000 position.

---

## Hard Rules (George Must Never Break These)

- **£1,000 absolute maximum** per stock — no exceptions, ever
- **No ETFs** — individual stocks only
- **No gambling, weapons, or crypto-linked stocks**
- **Never sell a position to fund another** — new cash only
- **Stop deploying capital** if portfolio drawdown hits 20–25%
- **Never invest in a stock** without completing the full scoring process first

---

## Tech Stack

| Component | Tool |
|-----------|------|
| Agent runtime | Claude Code |
| Trade execution | Alpaca Paper Trading API |
| Market research | Perplexity AI |
| Conviction scoring | n8n webhook |
| Notifications | Email |
| Memory & persistence | Markdown files + GitHub |

---

## Key Files

```
/
├── README.md                  ← You are here
├── CLAUDE.md                  ← Project instructions for George (routines, memory, guardrails)
├── GEORGE_STRATEGY.md         ← Full trading strategy document
├── memory/
│   ├── portfolio.md           ← Current holdings and performance
│   ├── watchlist.md           ← Stocks under consideration
│   └── decisions.md           ← Log of all buy/sell decisions with rationale
├── logs/
│   ├── trades.md              ← Silent log of every trade placed
│   └── research.md            ← Silent log of every stock researched but not bought
└── reports/
    ├── daily/                 ← Daily summary reports
    └── weekly/                ← Weekly performance reports vs S&P 500
```

---

## Target Performance

| Metric | Target |
|--------|--------|
| Time horizon | 5 years |
| Total return target | 75–100% |
| Annualised return target | ~12–15% |
| Benchmark | S&P 500 total return |
| Starting capital | Paper trading (TBD) |

---

## What George Will Not Do

- Chase short-term price movements
- Sell a winner just because the price has risen
- Hold a position whose original thesis has broken
- Invest in a stock without running the full scoring process
- Exceed the £1,000 per-stock hard cap under any circumstances
- Make decisions based on share price alone (fractional shares mean price per share is irrelevant)

---

## Development Roadmap

1. **CLAUDE.md** — Define George's routines, memory architecture, and operational instructions
2. **n8n Webhook** — Build the conviction scoring engine that receives raw scores and returns position budgets
3. **Alpaca Integration** — Connect George to paper trading execution
4. **Email Notifications** — Wire up daily summaries, weekly reports, and instant alerts
5. **GitHub Persistence** — Ensure George commits his state at the end of every run
6. **Paper Trading Period** — Run George for a meaningful period before considering real capital
7. **Review and Iterate** — Assess strategy performance vs S&P 500, refine as needed

---

## Contributing

This is a solo project. George is the only one making trades.

---

*Built with Claude Code · Powered by Alpaca · Scored by n8n · Benchmarked against the S&P 500*
