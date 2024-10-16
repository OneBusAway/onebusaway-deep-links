import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["showOnStopsCheckbox", "visibleStopList", "visibleRouteList"];

    connect() {
        console.log('Connected to toggle_stop_route_controller');
        this.toggleStopAndRouteLists();
    }

    toggleStopAndRouteLists() {
        const isDisabled = !this.showOnStopsCheckboxTarget.checked;
        this.visibleStopListTarget.disabled = isDisabled;
        this.visibleRouteListTarget.disabled = isDisabled;

        this.visibleStopListTarget.style.opacity = isDisabled ? '0.5' : '1';
        this.visibleRouteListTarget.style.opacity = isDisabled ? '0.5' : '1';
    }

    toggle() {
        this.toggleStopAndRouteLists();
    }
}