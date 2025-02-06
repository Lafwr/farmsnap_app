import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    marker: Object // Add for the single marker
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })

    if (this.hasMarkersValue) {
      // If there are multiple markers (index page)
      this.#addMarkersToMap()
      this.#fitMapToMarkers()
    } else if (this.hasMarkerValue) {
      // If there is a single marker (show page)
      this.#addMarkerToMap()
      this.#fitMapToMarker()
    }
  }

  // Handles multiple markers for index pages
  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)

      const customMarker = document.createElement("div")
      customMarker.innerHTML = marker.marker_html

      new mapboxgl.Marker(customMarker)
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(this.map)
    })
  }

  #fitMapToMarkers() {
    if (this.markersValue.length === 0) return

    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([marker.lng, marker.lat]))

    // Center the map on the first result
    const firstMarker = this.markersValue[0]
    this.map.setCenter([firstMarker.lng, firstMarker.lat])

    // Fit all markers into view
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }

  // Handles single marker for show pages
  #addMarkerToMap() {
    const popup = new mapboxgl.Popup().setHTML(this.markerValue.info_window_html)

    const customMarker = document.createElement("div")
    customMarker.innerHTML = this.markerValue.marker_html

    new mapboxgl.Marker(customMarker)
      .setLngLat([this.markerValue.lng, this.markerValue.lat])
      .setPopup(popup)
      .addTo(this.map)
  }

  #fitMapToMarker() {
    this.map.setCenter([this.markerValue.lng, this.markerValue.lat])
    this.map.setZoom(14) // Adjust zoom level for better focus on single marker
  }
}
