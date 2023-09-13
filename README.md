# Uber Data Analysis Project 📈

This project involves the analysis and visualization of Uber ride data from April to September 2014. The project is divided into several stages, including data retrieval, pre-processing, data processing using `dplyr`, and data visualization using `ggplot2`, `ggthemes`, and `scales`. The goal is to gain insights into Uber ride patterns during this period and create informative visualizations.

## Project Structure 👨🏻‍💻

The project is structured as follows:

1. **Loading Required Packages**: We start by loading the necessary R packages, such as `tidyr`, `dplyr`, `ggplot2`, and others.

2. **Data Retrieval**: Uber ride data for each month from April to September 2014 is loaded into separate data frames and then combined into a single data frame.

3. **Data Pre-processing**: We perform data pre-processing using the `lubridate` and `tidyr` libraries to convert date and time columns into appropriate formats and create new columns for analysis.

4. **Writing Tidy Data**: The cleaned and pre-processed data is written to a new CSV file for further analysis.

5. **Data Processing & Visualization**: We use the `dplyr` library for data processing and `ggplot2`, `ggthemes`, and `scales` for data visualization. We create various plots and visualizations to explore Uber ride patterns, including trips by day, month, hour, weekday, and base, as well as heatmaps and geographic maps.

## Data Visualizations 📊

The project includes a variety of data visualizations, including bar charts, heatmaps, and geographic maps, to showcase different aspects of the Uber ride data. Some of the visualizations include:

- Trips every day
- Trips by day and month
- Trips every hour
- Trips by hour and month
- Trips every month
- Trips by days of the week and month
- Trips by days of the week
- Trips by bases
- Trips by bases and month
- Heatmaps by hour and day, month and day, month and days of the week, and days of the week and bases
- Geographic maps of Uber rides in NYC during April to September 2014

## Conclusion 🏁

This Uber Data Analysis project provides valuable insights into ride patterns and trends during the specified period. The visualizations help in understanding the distribution of Uber rides across different time frames, days of the week, bases, and geographic locations within New York City.

Feel free to explore the code and visualizations to gain a deeper understanding of the Uber ride data from 2014.

## Contributing 💡

Contributions are welcome! If you have any ideas for improvements, bug fixes, or new features, please open an issue or submit a pull request.

## License ⚖️

This project is licensed under the [MIT License](LICENSE).
