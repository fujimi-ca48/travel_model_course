document.addEventListener('turbo:load', () => {
    const createImageHTML = (blob, previewId) => {
      const imageElement = document.getElementById(previewId);
      const blobImage = document.createElement('img');
      blobImage.setAttribute('class', 'new-img');
      blobImage.setAttribute('src', blob);
  
      imageElement.appendChild(blobImage);
    };
  
    const imageInputs = document.querySelectorAll('.image-input');
  
    imageInputs.forEach((input) => {
      input.addEventListener('change', (e) => {
        const imageContent = e.target.nextElementSibling; // .image-preview element
        const previewId = imageContent.id;
        const existingImage = imageContent.querySelector('img');
        if (existingImage) {
          existingImage.remove();
        }
  
        const file = e.target.files[0];
        const blob = window.URL.createObjectURL(file);
        createImageHTML(blob, previewId);
      });
    });
  }); 
