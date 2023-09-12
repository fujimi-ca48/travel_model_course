// カウントを取得し、カウントを表示する関数
function getCountAndDisplay() {
    fetch('/total_spot_items/get_total_spot_items_count')
      .then((response) => response.json())
      .then((data) => {
        const count = data.count;
        updateCountBadge(count);
      })
      .catch((error) => {
        console.error('Error fetching total_spot_items count:', error);
      });
  }
  
  // カウントを表示する関数
  function updateCountBadge(count) {
    const countBadge = document.getElementById('total-spot-items-count-badge');
    if (countBadge) {
      if (count > 0) {
        countBadge.style.display = 'block'; // カウントが0より大きい場合、赤丸を表示
        countBadge.textContent = count;
      } else {
        countBadge.style.display = 'none'; // カウントが0の場合、赤丸を非表示
      }
    }
  }
  
  // ページ読み込み時に初回のカウントを取得
  document.addEventListener('turbo:load', getCountAndDisplay);
  
  // 一定の間隔でカウントを取得し更新
  setInterval(getCountAndDisplay, 1000);
