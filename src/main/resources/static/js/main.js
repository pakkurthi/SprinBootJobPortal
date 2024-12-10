// src/main/resources/static/js/main.js
document.addEventListener('DOMContentLoaded', function() {
    // Initialize tooltips
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });

    // Form validation
    const forms = document.querySelectorAll('.needs-validation');
    Array.from(forms).forEach(form => {
        form.addEventListener('submit', event => {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        }, false);
    });

    // Dynamic rating system
    const ratingInputs = document.querySelectorAll('.rating-input');
    ratingInputs.forEach(input => {
        input.addEventListener('change', function() {
            const stars = this.closest('.rating-container').querySelectorAll('.star-icon');
            const rating = this.value;
            
            stars.forEach((star, index) => {
                if (index < rating) {
                    star.classList.add('filled');
                } else {
                    star.classList.remove('filled');
                }
            });
        });
    });

    // File upload preview
    const fileInput = document.querySelector('.custom-file-input');
    if (fileInput) {
        fileInput.addEventListener('change', function() {
            const fileName = this.files[0].name;
            const label = this.nextElementSibling;
            label.textContent = fileName;
        });
    }

    // Search functionality
    const searchInput = document.querySelector('#professionalSearch');
    if (searchInput) {
        searchInput.addEventListener('input', debounce(function() {
            filterProfessionals(this.value);
        }, 300));
    }
});

// Utility function for debouncing
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

// Filter professionals based on search input
function filterProfessionals(searchTerm) {
    const professionals = document.querySelectorAll('.professional-card');
    searchTerm = searchTerm.toLowerCase();

    professionals.forEach(card => {
        const name = card.querySelector('.professional-name').textContent.toLowerCase();
        const skills = card.querySelector('.professional-skills').textContent.toLowerCase();
        
        if (name.includes(searchTerm) || skills.includes(searchTerm)) {
            card.style.display = '';
        } else {
            card.style.display = 'none';
        }
    });
}
