% this is how you put comments
% Define the path to your data file
kaggle_data_file = "C:\Users\Cp9-30\Desktop\exercise one\athlete_events.csv";
kaggle_data = readtable(kaggle_data_file); % now kaggle_data is a table with our CSV data


% This is done ONCE, before the loop starts.
struct_arrays = struct(); % this is the parent structural array for the various years

% Get a list of all unique years in the data
unique_years = unique(kaggle_data.Year); % this function collects unique values from the "Year" column of our data

% Define the output file path
output_file = "C:\Users\Cp9-30\Desktop\exercise one\output.xlsx";

% main functionality starts here
for i = 1:length(unique_years)
    year = unique_years(i); 
        
    % Filter the main table to get data for only the current year
    year_data = kaggle_data(kaggle_data.Year == year, :); % == is a comparison operator
    
    % Creating a dynamic field name ---
  
    currentYear = sprintf('Year_%d', year);  % creating a name to use on the sheet
    
    % Convert the year's data table into a struct array
    S = table2struct(year_data); % converting the table into a structural array
    
    % Adding the year's data as a new field to the parent struct ---

    struct_arrays(i).(currentYear) = S;
    
    % Write the current year's data to a new sheet in the Excel file
    sheet_name = currentYear;
    writetable(year_data, output_file, 'Sheet', sheet_name);
end


% To see the overall structure and its fields:
disp('Loop finished. Displaying the final struct:');
disp(struct_arrays);

% Show a list of all the fields (all the years) we created:
disp('All field names in the struct:');
disp(fieldnames(struct_arrays));

disp('Data has been written to Excel file.');