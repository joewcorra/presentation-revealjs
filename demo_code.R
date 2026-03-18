library(pins)
library(tidyverse)

library(pins)

# Create a Local Board------------------
# Create a board in a local folder

# Creates folder if none exists
my_board <- board_folder("penguins_board", versioned = TRUE)



# Pin Some Data-----------------

# Sample data
my_penguins <- penguins %>%
  filter(species == "Adelie")

# Pin it with metadata
pin_write(
  my_board, 
  my_penguins,
  name = "adelie-penguins",
  title = "Adelie Penguins",
  # type = "csv", # Defaults to .rds
  description = "Palmer Penguins: Adelies only"
)


# Read the Pin---------------

# List available pins
pin_list(my_board)

# Read the pin
retrieved_data <- pin_read(my_board, "adelie-penguins")

# View it
head(retrieved_data)


# Update and Version--------------

# Update the data
my_updated_penguins <- retrieved_data %>%
  mutate(observer = "Firstname Lastname")

# Write again (creates new version)
my_board %>% pin_write(my_updated_penguins, "adelie-penguins")



# Access Specific Versions--------

# Check versions
my_board %>% pin_versions("adelie-penguins")

# Read a specific version
old_penguins <- my_board %>% pin_read(
  "adelie-penguins",
  version = "20260317T190742Z-0156c"  # old timestamp
)

# Prune old versions (keep last 5)
my_board %>% pin_versions_prune("adelie-penguins", n = 5)


# Metadata and Discovery---------


# View metadata
my_board %>% pin_meta("adelie-penguins")

# Search for pins
my_board %>% pin_search("penguins")

# Delete a pin
my_board %>% pin_delete("adelie-penguins")
# NOTE: Sometimes you'll get an error due to OneDrive 


# Real World Example: targets pipeline for GHGI Fossil Fuels----------

# Define the pins board for data retrieval
board <- board_folder("pins", versioned = TRUE)

# Define the Pipeline

list(
  
  ## Data Retrieval
  
  ### Both national and state
  tar_target(
    carbon_factors_fixed,
    pin_read(board, "carbon_factors_fixed")
  ),
  
  tar_target(
    carbon_factors_variable,
    pin_read(board, "carbon_factors_variable")
  ),
  
  tar_target(
    neu_storage,
    pin_read(board, "neu_storage")
  ),
  
  tar_target(
    msn_eia,
    pin_read(board, "msn")
  ),
  
  ### National--------------------------------------------
  tar_target(
    moves3_fuel,
    pin_read(board, "moves3_fuel")
  ),
  
  tar_target(
    moves3_vmt,
    pin_read(board, "moves3_vmt")
  ),
  
  tar_target(
    ippu_corrections,
    pin_read(board, "ippu_corrections")
  ),
  
  # Biodiesel for mobile calcs
  tar_target(
    biodiesel,
    pin_read(board, "biodiesel")
  ),
  
  # Rail diesel for mobile calcs
  tar_target(
    rail_diesel,
    pin_read(board, "rail_diesel")
  ),
  
  # Backcast nonroad data for mobile
  tar_target(
    nonroad_backcast,
    pin_read(board, "nonroad_backcast")
  ),
  
  ### State-----------------------------------------------
  
  tar_target(
    international_bunker_fuels,
    pin_read(board, "international_bunker_fuels")
  ),
  
  tar_target(
    non_energy_use,
    pin_read(board, "non_energy_use")
  ),
  
  tar_target(
    ippu_dist_ammonia,
    pin_read(board, "ippu_dist_ammonia")
  ),
  
  tar_target(
    ippu_dist_petrochemical,
    pin_read(board, "ippu_dist_petrochemical")
  ),
  
  tar_target(
    ippu_dist_carbon_black,
    pin_read(board, "ippu_dist_carbon_black")
  ),
  
  tar_target(
    ippu_dist_iron_and_steel,
    pin_read(board, "ippu_dist_iron_and_steel")
  ),
  
  tar_target(
    foks_diesel,
    pin_read(board, "foks_diesel")
  ),
  
  tar_target(
    foks_residual,
    pin_read(board, "foks_residual")
  ),
  
  tar_target(
    feedstock_export_adjustments,
    pin_read(board, "feedstock_export_adjustments")
  ),
  
  # temporary
  tar_target(
    api_seds,
    pin_read(board, "api_seds")
  ))
