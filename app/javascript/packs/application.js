// app/javascript/packs/application.js

document.addEventListener("DOMContentLoaded", () => {
  const manualButton = document.getElementById("manual-button");
  
  if (manualButton) { // manualButtonがnullでないことを確認
    manualButton.addEventListener("click", (event) => {
      event.preventDefault();
      const dropdownMenu = document.getElementById("manual-dropdown");

      // 非同期通信でマニュアルの選択肢を取得
      fetch("/manuals") // ここにマニュアルの選択肢を取得するルートを設定
        .then(response => response.json())
        .then(data => {
          dropdownMenu.innerHTML = ""; // 既存のメニューをクリア
          
          data.forEach(manual => {
            const li = document.createElement("li");
            // JavaScript内でリンク要素を作成
            const link = document.createElement("a");
            link.href = manual.path; // マニュアルのリンク先
            link.textContent = manual.title; // マニュアルのタイトル

            li.appendChild(link); // li要素にリンクを追加
            dropdownMenu.appendChild(li); // ドロップダウンメニューに追加
          });
        })
        .catch(error => console.error("Error fetching manuals:", error));
    });
  }
});