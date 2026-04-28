window.careerDataLayer = window.careerDataLayer || {};

// Function to push data to the dataLayer
window.careerDataLayer.pushEvent = function(eventType, formName, location, department, jobTitle) {
    if (typeof window.dataLayer !== 'undefined') {
        window.dataLayer.push({
            'event': "form_interaction",
            'form_event_type': eventType,
            'form_name': formName,
            'type': location,
            'category': department,
            'name': jobTitle
        });
    } else {
        console.warn("dataLayer is not defined");
    }
};