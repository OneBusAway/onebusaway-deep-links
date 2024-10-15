document.addEventListener("turbo:load", function () {
    const showOnStopsCheckbox = document.getElementById('survey_show_on_stops');
    const visibleStopList = document.getElementById('survey_visible_stop_list');
    const visibleRouteList = document.getElementById('survey_visible_route_list');

    function toggleStopAndRouteLists() {
        const isDisabled = !showOnStopsCheckbox.checked;
        visibleStopList.disabled = isDisabled;
        visibleRouteList.disabled = isDisabled;

        visibleStopList.style.opacity = isDisabled ? '0.5' : '1';
        visibleRouteList.style.opacity = isDisabled ? '0.5' : '1';
    }

    toggleStopAndRouteLists();

    showOnStopsCheckbox.addEventListener('change', toggleStopAndRouteLists);
});
