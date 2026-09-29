# GoalBot for Hyperliquid

A web app that trades a Hyperliquid perpetual automatically and stops when your account reaches a money goal. It also stops if the account drops to a loss floor. It connects with MetaMask.

## Start it
MetaMask only works on pages served over http, not on a double-clicked file. So use the launcher:

- **Mac:** double-click `start.command`. If macOS blocks it, right-click it and choose **Open**.
- **Windows:** double-click `start.bat`. Needs Python from python.org.
- **Linux:** `./start.sh`

Your browser opens http://localhost:8765. Leave the launcher window open while you use the app.

You can also put `index.html` on any static host (Netlify Drop, GitHub Pages, Vercel). It's a single file.

## Use it
1. **Paper** (default): real Hyperliquid prices, pretend money, no wallet needed. Set a goal and press **Start bot**.
2. **Backtest**: runs the strategy over the last 3,000 candles.
3. **Live → Testnet**: get test USDC at https://app.hyperliquid-testnet.xyz/drip.
   Click **Connect MetaMask**, then **Authorize bot**. MetaMask asks for one gas-free signature. That approves a trading key, stored in this browser, which **can place orders but cannot withdraw**.
4. **Live → Mainnet**: the same steps, with real money. Authorize separately.

## New: wallet scan
Connect MetaMask and GoalBot scans your wallet on Ethereum, Arbitrum, Base, Optimism, Polygon, BNB Chain, Avalanche and HyperEVM, plus your Hyperliquid trading and spot balances. It shows every holding with its value and what it takes to use it for trading:
- **Hyperliquid trading balance:** what the bot trades with.
- **Hyperliquid spot USDC:** **Move to trading** in one MetaMask signature (no gas).
- **USDC on Arbitrum:** **Deposit to trade**, which switches network and fills in the amount.
- **Anything else** (ETH, USDT, other networks): shows the swap or bridge step needed first.
- **Paper mode:** **Use as paper balance** practices with your real wallet size.

Only common tokens are checked, and the scan is read-only. Nothing moves without your MetaMask approval.

## New in version 2
- **Multiple markets:** trade up to 6 Hyperliquid perps at once (BTC, ETH, SOL, HYPE…) with one shared goal. Each market has its own chart tab. The leverage budget is split between them, and every stop-loss together can't push the account past your floor.
- **Your currency:** show everything in AUD, EUR, GBP, JPY and 16 more. Rates are daily reference rates. Hyperliquid itself holds USDC, and the goal stays fixed in USD behind the scenes.
- **MetaMask on any network:** connect and authorize from Ethereum, Arbitrum, Base, Optimism, Polygon, BNB Chain, Avalanche or HyperEVM. Switch networks from the Wallet panel. Missing networks are added to MetaMask for you. See your ETH and USDC balances and your Hyperliquid balance.
- **Deposit USDC:** from the Wallet panel, sends native USDC on Arbitrum (or Arbitrum Sepolia for testnet) to Hyperliquid's official bridge. Minimum 5 USDC, because smaller deposits are lost, and the app blocks them. The token is checked on-chain before anything is sent. For other networks, bridge to Arbitrum first or use app.hyperliquid.xyz.

## What it does
- **Goal:** when account value ≥ goal, it closes everything and stops.
- **Floor:** when account value ≤ floor, it closes everything and stops.
- **Daily loss limit:** flattens and pauses until the next UTC day.
- **Strategy:** trades on 20/50 EMA crossovers. Stop-loss is 2× ATR, take-profit is 4× ATR, and each trade risks 1% of the account. Position size is capped so one stop can't blow through the floor.
- **Live-mode stops:** each trade's stop-loss and take-profit are also placed **on the exchange**, so they still work if you close the tab.

## Keep in mind
- The goal and floor checks and new entries only run **while the tab is open**. Keep the computer awake.
- Anyone with access to this browser profile could use the stored trading key to trade, but not to withdraw. Use **Forget key**, or revoke it in Hyperliquid under More → API.
- The goal is a stop condition, not a promise. The strategy can lose money. Leverage magnifies losses. This isn't financial advice.
- Independent tool, not affiliated with Hyperliquid.
