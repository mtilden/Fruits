-- Name:   Madison Tilden
-- Date:   October XX, 2014
-- Course: ITEC 320 Principles of Procedural Programming 

-- Purpose: This program is to help a fruit breeder analyze a set of 
-- data describing fruit trees and sample pieces of fruit found on those trees. 
-- You can enter your data from the command line or from a file
-- The input file will contain data on between one and one thousand trees, 
-- inclusive, and on between 0 and 20 samples per tree, also inclusive.
-- The information for each tree will be a sequence of items as follows:
-- The keyword "TREE".
-- A tree identification string of exactly 7 letters or digits.
-- After a tree identification string come a possibly empty sequence of
-- data on fruit samples. Each piece of fruit will be introduced by the
-- keyword "FRUIT", followed by three words to describe the following 
-- characteristics, in this order:
-- Size: small, midsize, large
-- Firmness: soft, firm, hard
-- Taste: bland, sweet, sour
-- A tree with a given ID number can appear more than once in the data.
-- Standard input will contain a sequence of commands that will direct 
-- the program's output. These commands determine program output and operation, as follows:
-- "Trees": Output only Tree id number and number of fruit samples
-- "Averages": Output as in Trees, plus the average and standard deviation of each category for each tree.
-- "Fruits": Output as in Trees, plus each fruit and average and standard deviation as in Averages
-- "Quit": Halt the program




WITH Ada.Text_IO; USE Ada.Text_IO;
--with ada.characters.handling; use  ada.characters.handling;
--WITH ada.Command_Line; USE ADA.Command_Line;


procedure fruit is
  --package cmdl renames ada.command_line;

--	eol: boolean;

-------------------------------------------------------------
-------------------------------------------------------------
    my_file: File_Type;
    os_name: String := "test1.dat";
	
	type keyword is (tree, fruit);
	package Key_IO is new Ada.Text_IO.Enumeration_IO(keyword);
	use Key_IO;
	key: keyword;
-------------------------------------------------------------
-------------------------------------------------------------
  procedure getSpaces(file: in File_Type) is
  	   c: character;
  BEGIN
  	while c = ' ' loop
  		get(file, c);
  	end loop;
  END getSpaces;
-------------------------------------------------------------
-------------------------------------------------------------
  procedure getKey(file: in File_Type; k: out keyword) is 
  BEGIN
	  get(file, k);
  END getKey;
-------------------------------------------------------------
-------------------------------------------------------------
  procedure putKey(k: in keyword) is 
  BEGIN
	  put(k);
  end putKey;
-------------------------------------------------------------
-------------------------------------------------------------
	maxIDLen : constant := 7;
--	type fruit_size is (small, midsize, large);			-- characteristics for size of fruit 
--	type fruit_firmness is (soft, firm, hard);			-- characteristics for frimness of fruit 
--	type fruit_taste is (bland, sweet, sour);			-- characteristics for taste of fruit 

--  package fsize_IO is new Ada.Text_IO.Enumeration_IO(fruit_size);
--  package ffirmness_IO is new Ada.Text_IO.Enumeration_IO(fruit_firmness);
--  package ftaste_IO is new Ada.Text_IO.Enumeration_IO(fruit_taste);

--  use fsize_IO;
--  use ffirmness_IO;
--	use ftaste_IO;

--	type fruitInfo is record					-- information needed for each fruit given
--		size: fruit_size;						-- size of the fruit 
--		firmness: fruit_firmness;				-- firmness of the fruit
--		taste: fruit_taste;						-- how the fruit tastes
--	end record;									-- end of fruitInfo record

--	type fruitArray is array(0 .. 20) of fruitInfo;		

--		fruit: fruitInfo;

    type treeInfo is record					  -- information needed for each new tree
		id: String (1 .. maxIDlen);			  -- ID numbers can be in input multipule times not case sensitive!
		num_fruits: Positive := 0;
		fruit_Arr : fruitArray;				  -- array of fruits 0 .. 20
    end record;								  -- end treeInfo record
	
	maxArr: constant := 1000;
	minArr: constant := 1;
    type treeArray is array (minArr .. maxArr) of treeInfo;
	
    t_array: treeArray;
	mytree: treeInfo;

    num_trees : Natural := 0;
	current : Natural := 0;

-------------------------------------------------------------
-------------------------------------------------------------
  procedure check_tree_exist(tarray: in treeArray; trees : in out Natural;
  	 								id: in string; current: in out Natural) is
  BEGIN
	  for i in 1 .. trees loop
		  if tarray(i).id(1 .. id'length) = w then
			  current := i;
			  trees := trees - 1;
		  else
			  current := trees;
		  end if;
	  end loop;
		  
  END check_tree_exist;
-------------------------------------------------------------
-------------------------------------------------------------
  procedure getID(file : in File_Type; tarray : in out treeArray;
  	 									trees : in out Natural; current: out Natural) is
	  temp: string (1 .. 7);
	    
  BEGIN
	  get(file, temp);
	  check_tree_exist(tarray, trees, temp, current);
--	  if current = trees then 
	  	tarray(current).id := temp;
--	  else
--		tarray(current).id := temp;
--	  end if;
  END getID;
-------------------------------------------------------------
-------------------------------------------------------------
--  procedure getFruitInfo(file: in File_Type; tarray: in out TreeArray) is
--  BEGIN
--	  get()
--  END getFruitInfo;
-------------------------------------------------------------
-------------------------------------------------------------

procedure handleNextKey(my_file: in out File_Type; key: in out keyword; num_trees: in out Positive;
										t_array: in out treeArray) is
BEGIN
	getSpaces(my_file);
	getKey(my_file, key);
	getSpaces(my_file);
	if key = tree then 
		num_trees := num_trees + 1;
		getID(my_file, t_array, num_trees, current);
		handleNextKey(my_file, key, num_trees, t_array);
	elsif key = fruit then
		--t_array(current).num_fruits := t_array(current).num_fruits + 1;	
		put("You got key fruit and havent handled it yett.. goodjob");
		handleNextKey(my_file, key, num_fruits, t_array)
	else 
		put("I need an exception here too.");
	end if;
END handleNextKey;

  -------------------------------------------------------------
  -------------------------------------------------------------
BEGIN 

  open(file => my_file, mode => In_File, name => os_name);

  loop
	  exit when end_of_file (my_file);
	
	  getKey(my_file, key);
	
	  if key = tree then
		num_trees := num_trees + 1;
		getSpaces(my_file, c);
		getID(my_file, t_array, num_trees);
		handleNextKey(my_file, key, num_trees, t_array);
	  else 
	 	Put("I'm going to keep going because i have no exceptions in now but tree should be first!");
	  end if;
	
  end loop; 	-- end while not end of file loop
	
end fruit;
