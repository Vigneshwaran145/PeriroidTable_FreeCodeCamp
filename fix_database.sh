PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

#Each row in your properties table should have a type_id value that links to the correct type from the types table
$($PSQL "update properties set type_id=(select type_id from types where types.type=properties.type);")

#You should capitalize the first letter of all the symbol values in the elements table. Be careful to only capitalize the letter and not change any others
$($PSQL "update elements set symbol=INITCAP(symbol);")

#You should remove all the trailing zeros after the decimals from each row of the atomic_mass column. You may need to adjust a data type to DECIMAL for this. The final values they should be are in the atomic_mass.txt file
$($PSQL "alter table properties alter column atomic_mass type real;")

#