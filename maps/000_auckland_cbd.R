library(leaflet)

# Define the updated, more precise Christchurch CBD boundary including Hagley Park
auckland_cbd_coords <- list(
  c(174.7673, -36.8434),  # Point A: Quay Street (East)
  c(174.7568, -36.8450),  # Point B: Viaduct Harbour (West)
  c(174.7552, -36.8475),  # Point C: Victoria Park (Beaumont St)
  c(174.7574, -36.8583),  # Point D: Karangahape Road (Ponsonby Rd)
  c(174.7668, -36.8584),  # Point E: Karangahape Road (Symonds St)
  c(174.7703, -36.8538),  # Point F: Grafton Road (Symonds St)
  c(174.7713, -36.8506),  # Point G: Bottom of Symonds St
  c(174.7673, -36.8434)   # Closing Point A (Quay Street)
)


# Create a leaflet map and plot the Christchurch CBD boundary
leaflet() %>%
  addTiles() %>%
  addPolygons(
    lng = sapply(auckland_cbd_coords, function(x) x[1]),
    lat = sapply(auckland_cbd_coords, function(x) x[2]),
    color = "blue",  # Border color
    fillColor = "lightblue",  # Fill color
    fillOpacity = 0.5,  # Opacity of the polygon fill
    weight = 2,  # Thickness of the border line
    popup = "Auckland CBD"
  ) %>%
  setView(174.7645, lat = -36.8509, zoom = 13)
