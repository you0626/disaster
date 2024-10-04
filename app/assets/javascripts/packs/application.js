// app/javascript/packs/application.js

document.addEventListener("DOMContentLoaded", () => {
  const manualButton = document.getElementById("manual-button");
  
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
          li.innerHTML = `<%= link_to manual.title, manual.path %>`;
          dropdownMenu.appendChild(li);
        });
      })
      .catch(error => console.error("Error fetching manuals:", error));
  });
});