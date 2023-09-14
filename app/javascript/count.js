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

  function updateCountBadge(count) {
    const countBadge = document.getElementById('total-spot-items-count-badge');
    if (countBadge) {
      if (count > 0) {
        countBadge.style.display = 'block';
        countBadge.textContent = count;
      } else {
        countBadge.style.display = 'none';
      }
    }
  }
  
  document.addEventListener('turbo:load', getCountAndDisplay);
  
  setInterval(getCountAndDisplay, 1000);
