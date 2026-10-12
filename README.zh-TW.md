<div align="center">

# IKEA-STYLE MANUAL

**讓 agent 別再寫沒人看的文件，改畫組裝說明書。**

一個 agent skill：把任何教學、流程、新人指南，做成 IKEA 風格的組裝說明書——
線稿小人、巨大步驟編號、零件清單、✓/✕ 對照、可一鍵複製的指令卡，
全部收在**一個獨立的 HTML 檔**裡。

[**線上範例（繁中）**](https://vic-chen-160.github.io/ikea-style-manual/examples/pour-over-coffee.zh-TW.html) ·
[**線上範例（英文）**](https://vic-chen-160.github.io/ikea-style-manual/skills/ikea-style-manual/assets/template.html) ·
[English](README.md)

![說明書頁面](docs/hero.png)

</div>

## 安裝

**Claude Code（plugin）：**

```
/plugin marketplace add Vic-Chen-160/ikea-style-manual
/plugin install ikea-style-manual@ikea-style-manual
```

**手動安裝**——把 skill 資料夾複製進 agent 的 skills 目錄（以 Claude Code 為例）：

```bash
git clone https://github.com/Vic-Chen-160/ikea-style-manual.git
cp -r ikea-style-manual/skills/ikea-style-manual ~/.claude/skills/
```

## 使用

直接講：

> 用 IKEA 說明書的方式做一份 .html：新人第一天怎麼把開發環境裝好。

> 把這份 README 改成組裝說明書，指令全留、段落全砍。

> 照之前那份說明書的風格，再做一份「印表機怎麼連」。

Agent 會先拷問主題、只挑**一條**推薦路線（說明書不說「看情況」）、規劃頁面、
幫產品取一個假瑞典文名字（`KAFFEKOPP`、`ANVISNING`、`FLYTTA`…），
做完後**自己截圖檢查**桌機與手機版，修掉溢出和重疊才交件。

## 範例：手沖咖啡

12 頁的手沖咖啡說明書：零件清單、研磨粗細用砂糖和鹽比較、注水時間軸、「太酸／太苦／太淡」決策樹、可複製的配方卡。

![手沖咖啡說明書](docs/pages-zh.png)

## 盒內零件

封面、零件清單、兩人作業、全貌圖、步驟、零件袋（A–F 標註）、✓/✕ 對照、決策樹、循環圖、
絕對不要、保養清單、指令卡、封底求助頁——依主題挑 6–15 頁組合。

純 inline SVG＋CSS：離線可看、可列印成一頁一張、手機自動單欄，寬圖在框內左右滑而不是縮到看不見。

## 規矩

- 只給一條推薦路線，其他打叉並一句話說明原因。
- 每步最多 3 句話；要講更多，就多畫一格。
- 用數字不用形容詞：`8.4 MB ✕`／`240 KB ✓`。
- 白底黑線，不用品牌色。
- 交件前一定截圖——SVG 文字不會自動換行。

## 授權

MIT。靈感來自組裝家具說明書；與 IKEA 無任何關係，亦未獲其背書。
