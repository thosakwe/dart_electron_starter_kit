requirejs(['main.ddc'], function (app) {
    app.main.main();
}, function(err) {
    console.error(err);
    const el = document.createElement('i');
    el.style.color = 'red';
    el.textContent = 'Failed to load (maybe DDC is building). Reloading in 2 seconds...';
    document.body.appendChild(el);
    setTimeout(function() {
        window.location.reload();
    }, 2000);
});