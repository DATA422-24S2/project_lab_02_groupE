library(leaflet)

# Define the updated, more precise Christchurch CBD boundary including Hagley Park
chch_cbd_hagley_coords <- list(
  c(172.6130, -43.5243),  # North-West corner (Harper Ave and Deans Ave)
  c(172.6258, -43.5205),
  c(172.6515, -43.5205),  # North-East corner (Bealey Ave and Fitzgerald Ave)
  c(172.6515, -43.5400),  # South-East corner (Moorhouse Ave and Fitzgerald Ave)
  c(172.6115, -43.5400),  # South-West corner (Deans Ave and Moorhouse Ave)
  c(172.6115, -43.5243)   # Closing point back to North-West
)


# Create a leaflet map and plot the Christchurch CBD boundary
leaflet() %>%
  addTiles() %>%
  addPolygons(
    lng = sapply(chch_cbd_hagley_coords, function(x) x[1]),
    lat = sapply(chch_cbd_hagley_coords, function(x) x[2]),
    color = "green",  # Border color
    fillColor = "lightgreen",  # Fill color
    fillOpacity = 0.5,  # Opacity of the polygon fill
    weight = 2,  # Thickness of the border line
    popup = "Christchurch CBD"
  ) %>%
  setView(lng = 172.6300, lat = -43.5290, zoom = 13)
