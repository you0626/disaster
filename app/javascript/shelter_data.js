// app/javascript/shelter_data.js.erb
document.addEventListener('DOMContentLoaded', function() {
  const csvFilePath = '<%= asset_path(`shelters.csv`) %>'; // ERBを利用してCSVファイルのパスを取得

  console.log('CSV file path:', csvFilePath); // パスをコンソールに表示
  fetch(csvFilePath)
    .then(response => {
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
      return response.text();
    })
    .then(data => {
      const shelters = parseCSV(data);
      console.log('Response data:', data); // 読み込んだデータをコンソールに表示
      console.log(shelters); // 読み込んだデータをコンソールに表示
      // ここでGPS機能の実装などを行う
    })
    .catch(error => {
      console.error('There was a problem with the fetch operation:', error);
    });

  function parseCSV(data) {
    const rows = data.split('\n');
    const shelters = rows.slice(1).map(row => {
      const columns = row.split(',');
      return {
        municipality_code: columns[0],
        facility_name: columns[1],
        address: columns[2],
        latitude: columns[3],
        longitude: columns[4]
      };
    });
    return shelters;
  }
});