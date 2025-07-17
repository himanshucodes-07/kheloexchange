document.addEventListener('DOMContentLoaded', function() {
            var form = document.getElementById('uploadForm');
            var subjectInput = document.getElementById('subject');
            var messageInput = document.getElementById('message');
            var uploadButton = document.getElementById('uploadButton');
            var errorSubject = document.getElementById('errorSubject');
            var errorMessage = document.getElementById('errorMessage');

            function validateInput() {
                var isValid = true;

                errorSubject.textContent = '';
                errorMessage.textContent = '';

                if (subjectInput.value.length > 65535) {
                    isValid = false;
                    errorSubject.textContent = 'Input must not exceed 65,535 characters.';
                }

                if (messageInput.value.length > 65535) {
                    isValid = false;
                    errorMessage.textContent = 'Input must not exceed 65,535 characters.';
                }

                uploadButton.disabled = !isValid;
            }

            subjectInput.addEventListener('input', validateInput);
            messageInput.addEventListener('input', validateInput);

            form.addEventListener('submit', function(event) {
                validateInput();
                if (uploadButton.disabled) {
                    event.preventDefault();
                }
            });
        });