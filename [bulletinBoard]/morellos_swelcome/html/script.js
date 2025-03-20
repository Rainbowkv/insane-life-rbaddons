// Variables
let config = {};

// Listen for messages from the client script
window.addEventListener('message', function(event) {
    const item = event.data;
    
    if (item.action === "openWelcomeScreen") {
        config = item.config;
        setupWelcomeScreen();
        showWelcomeScreen();
    } else if (item.action === "closeWelcomeScreen") {
        hideWelcomeScreen();
    }
});

// Function to set up the welcome screen with config values
function setupWelcomeScreen() {
    // Set title
    document.getElementById('welcome-title').textContent = config.Title;
    
    // Set logo if provided
    const logoElement = document.getElementById('server-logo');
    if (config.Logo && config.Logo.trim() !== '') {
        logoElement.src = config.Logo;
        logoElement.style.display = 'block';
    } else {
        logoElement.style.display = 'none';
    }
    
    // Set background image or color
    const welcomeContainer = document.getElementById('welcome-container');
    if (config.BackgroundImage && config.BackgroundImage.trim() !== '') {
        welcomeContainer.style.backgroundImage = `url(${config.BackgroundImage})`;
        welcomeContainer.style.backgroundSize = 'cover';
        welcomeContainer.style.backgroundPosition = 'center';
    } else {
        welcomeContainer.style.backgroundColor = config.BackgroundColor || 'rgba(0, 0, 0, 0.7)';
    }
    
    // Set text color
    document.getElementById('welcome-content').style.color = config.TextColor || '#ffffff';
    
    // Set button text and colors
    document.getElementById('accept-text').textContent = config.AcceptButtonText || 'Entiendo';
    document.getElementById('decline-text').textContent = config.DeclineButtonText || 'Salir';
    
    document.getElementById('accept-button').style.backgroundColor = config.AcceptButtonColor || '#4CAF50';
    document.getElementById('decline-button').style.backgroundColor = config.DeclineButtonColor || '#f44336';
    
    // Clear existing sections
    const sectionsContainer = document.getElementById('sections-container');
    sectionsContainer.innerHTML = '';
    
    // Add sections from config
    if (config.Sections && Array.isArray(config.Sections)) {
        config.Sections.forEach(section => {
            const sectionElement = document.createElement('div');
            sectionElement.className = 'section';
            
            const titleElement = document.createElement('h2');
            titleElement.className = 'section-title';
            titleElement.textContent = section.title;
            
            const contentElement = document.createElement('div');
            contentElement.className = 'section-content';
            contentElement.innerHTML = section.content;
            
            sectionElement.appendChild(titleElement);
            sectionElement.appendChild(contentElement);
            sectionsContainer.appendChild(sectionElement);
        });
    }
}

// Function to show the welcome screen
function showWelcomeScreen() {
    document.getElementById('welcome-container').classList.remove('hidden');
}

// Function to hide the welcome screen
function hideWelcomeScreen() {
    document.getElementById('welcome-container').classList.add('hidden');
}

// Button event listeners
document.getElementById('accept-button').addEventListener('click', function() {
    $.post('https://morellos_swelcome/acceptWelcomeScreen', {});
});

document.getElementById('decline-button').addEventListener('click', function() {
    $.post('https://morellos_swelcome/declineWelcomeScreen', {});
});

// Prevent form submission
document.onkeyup = function(data) {
    if (data.which == 27) { // ESC key
        // We don't want to allow ESC to close the welcome screen
        // as the player must click one of the buttons
        return false;
    }
};
