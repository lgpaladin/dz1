require 'colorize'

class ForMenu

	@@error = ''

	def print_error
  	
  	unless @@error.empty?
	  	puts "\n#{@@error}".red

	  	@@error = ''
	  end
	end

	def press_any_key
  	
  	puts "\n\nДля продолжения нажмите Enter"
		gets
		@data = nil
	end

	def input_data input_message

		while true

			print "\n#{input_message}: " unless @data
			@data ||= gets.chomp

			if @data.empty?
		 		@@error = "Пустые данные. Попробуйте снова"
		  	@@data  = nil
		  else
		  	break	
			end
		end
	end

	def menu_choise

		menu_valid = [*"0"..@menu.size.to_s]

		while true
		
			print_menu
			point = gets.chomp

			if menu_valid.include?(point)
				return point
			else
				@@error = "Вы ввели недопустимое значение меню.\nПопробуйте снова"
		  end	
		end  
	end

	def print_menu
	  system("clear")
	  
	  puts "#{@title}".green
	  @menu.each {|key, val| puts "\t #{key} - #{val}"}
	  puts "\t 0 - Выход".blue

	  print_error

	  print "\nВведите пункт меню: "
	end

	def run
		
		while true

		  point = menu_choise
		  
		  if @prog[point] == "break"
		  	break
		  else
		  	send(@prog[point])
		  end	
		  
		  press_any_key
		end  
	end
end

class WorkOperations < ForMenu

	def initialize 
		@title = "Задачи на Линейные алгоритмы"
		@menu  = {'1' => "Сумма и произведение цифр числа",
				  	  '2' => "Битовые операции над числами"}
		@prog  = {'1' => "sum_and_mult",
					  	'2' => "bitwise_operations",
							'0' => "break"}
	end						 

	protected
	
	def sum_and_mult

		puts "\nНайти сумму и произведение цифр произвольного целого числа.".yellow
		
		input_data("Введите целое число любой длины")

		mult, sum = 1, 0

		@data.chars.each { |e| mult *= e.to_i; sum += e.to_i}
		puts "\nСумма цифр числа  =  #{sum}"
		puts "Произведение цифр числа  =  #{mult}"
	end

	def bitwise_operations

		puts "\nВыполнить логические побитовые операции \"И\", \"ИЛИ\" и др. над двумя числами.".yellow
		puts "Выполнить над первым числом побитовый сдвиг вправо и влево на два знака.".yellow

		input_data("Введите два целых числа (через пробел)")

		arr = @data.split(' ').map { |e| e.to_i }
		
		puts "\nЧисло #{arr[0]} в двоичном виде #{arr[0].to_s(2)}"
		puts "Число #{arr[1]} в двоичном виде #{arr[1].to_s(2)}"
		puts "Результат побитового \'И\'    =  #{arr[0] & arr[1]}"
		puts "Результат побитового \'ИЛИ\'  =  #{arr[0] | arr[1]}"
		puts "Результат побитового \'Исключающее ИЛИ\'  =  #{arr[0] ^ arr[1]}"
		puts "Результат побитового \'НЕ\'  для числа  #{arr[0]}  =  #{~arr[0]}"
		puts "Результат побитового сдвига влево  на 2 разряда для числа  #{arr[0]}  =  #{arr[0] << 2}"
		puts "Результат побитового сдвига вправо на 2 разряда для числа  #{arr[0]}  =  #{arr[0] >> 2}"
	end
end	

class WorkBranching < ForMenu

	def initialize 

		@title = "Задачи на Ветвления"
		@menu  = {'1' => "Определить високосный год или нет",
					    '2' => "Среди трех чисел найти среднее"}
		@prog  = {'1' => "leap_year",
						  '2' => "find_the_mean",
							'0' => "break"}
	end						 

	protected

	def leap_year	

		puts "\nОпределить, является ли год високосным или невисокосным.".yellow
		
		input_data("Введите год")

		year = @data.to_i

		if year % 4 != 0 || year % 100 == 0 && year % 400 != 0
			puts "#{year}  -  Обычный год"
		else
			puts "#{year}  -  Высокосный год"
		end		
	end

	def find_the_mean

		puts "\nНайти, какое из набора целых чисел является средним (больше одного, но меньше другого)".yellow
		
		input_data("Введите любое количество целых чисел (через пробел)")

		arr = @data.split(' ').map { |e| e.to_i }
		arr.sort!
		arr.uniq!
		size = arr.size

		if size % 2 == 0
			puts "\nСреди четного количества чисел, невозможно найти средннее по значению".red
		else	
			puts "\nСреднее число из введенных  -  #{arr[(size / 2).to_i]}"
		end		
	end
end

class WorkCycles < ForMenu

	def initialize
		@title = "Задачи на Циклы"
		@menu  = {'1' => "Посчитать четные и нечетные цифры числа",
						  '2' => "Вывод таблицы символов ASCII на экран"}
		@prog  = {'1' => "even_odd",
						  '2' => "ascii_table",
							'0' => "break"}
	end						

	protected

	def even_odd

		puts "\nПосчитать количество четных и нечетных цифр введенного натурального числа.".yellow
		
		input_data("Введите целое число любой длины")

		even, odd = 0, 0

		@data.chars.each { |e| e.to_i % 2 == 0 ? even += 1 : odd += 1 }

		puts "\nКоличество четных цифр  =  #{even}"
		puts "Количество не четных цифр =  #{odd}"
	end

	def ascii_table

		puts "\nВыводит на экран коды и символы таблицы ASCII из заданного пользователм диапазона.".yellow
		puts "Вывод выполнен в табличной форме: по десять пар \"код-символ\" в каждой строке.".yellow
		
		input_data("Введите два целых числа (через пробел)")

		arr = @data.split(' ').map { |e| e.to_i }

		puts
		
		n = 1
		for i in arr[0]..arr[1] do
			
			print i.to_s.ljust(3) + " - #{i.chr}   "
			puts if (i - arr[0] + 1) % 10 == 0 

		end
		puts 
	end	
end	

class WorkNestedLoops < ForMenu

	def initialize
		@title = "Задачи на Вложенные циклы"
		@menu  = {'1' => "Прямоугольник из символов",
						  '2' => "Найти совершенные числа"}
		@prog  = {'1' => "rectangle",
						  '2' => "perfect_number",
							'0' => "break"}
	end						

	protected

	def rectangle

		puts "\nВыводит на экран \"прямоугольник\", образованный из двух видов символов.".yellow
		puts "Контур прямоугольника состоит из одного символа, а в \"заливка\" - из другого.".yellow
		
		input_data("Введите два символа (через пробел)")

		arr = @data.split(' ')

		for i in 1..10
			puts
			for j in 1..20

				if i == 1 or i == 10 or j == 1 or j == 20
					print arr[0].to_s.green
				else
					print arr[1]
				end
			end
		end
	end

	def perfect_number

		puts "\nНайти все совершенные числа до 10000".yellow
		puts "Совершенное число - это такое число, которое равно сумме всех своих делителей, кроме себя самого.\n".yellow
		
		arr = []

		for i in 2..10000

			arr.clear

			for j in 1..i-1
				
				arr << j if i % j == 0
			
			end

			puts i.to_s.ljust(4) + "  -  #{arr}" if arr.sum == i

		end
	end	
end

class WorkArray < ForMenu

	def initialize
		@title = "Задачи на работу с Массивами"
		@menu  = {'1' => "Поменять местами минимальный и максимальный элементы",
						  '2' => "Число, чаще всего встречающееся в массиве"}
		@prog  = {'1' => "min_max_change",
						  '2' => "most_often",
							'0' => "break"}
	end						

	protected

	def min_max_change

		puts "\nВ массиве случайных целых чисел поменяем местами минимальный и максимальный элементы".yellow
		
		input_data("Введите массив целых чисел (через пробел)")

		arr = @data.split(' ')

		min_val, max_val = arr[0], arr[0]
		min_ind, max_ind = 0, 0

		arr.each_with_index do |val, ind|

			min_ind = ind if min_val < val
			max_ind = ind if max_val > val
		
		end

		arr[min_ind], arr[max_ind] = arr[max_ind], arr[min_ind]

		print arr
	end

	def most_often

		puts "\nОпределяем, какое число в массиве встречается чаще всего.".yellow
		
		input_data("Введите массив целых чисел (через пробел)")

		arr = @data.split(' ')
		arr.sort!

		max_count, count_val = 0, 0
		max_val, old_val = arr[0], arr[0]

		print arr
		puts

		arr.each do |val|

			if old_val != val
				if max_count < count_val
					max_count = count_val
					max_val		= old_val
					puts "if #{val}"
				end
				puts " #{old_val} - #{val} - #{count_val}"
				old_val   = val
				count_val = 1
				
			end

			count_val += 1
			
		end
		
		puts "\nЧисло \"#{max_val}\" встречается в массиве #{max_count} раз(а)"
	end	
end

class WorkMatrix < ForMenu

	def initialize
		@title = "Задачи на работу с Матрицами"
		@menu  = {'1' => "Обмен значений главной и побочной диагоналей квадратной матрицы",
						  '2' => "Суммы строк и столбцов матрицы"}
		@prog  = {'1' => "diagonal_change",
						  '2' => "sum_row_col",
							'0' => "break"}
	end						

	protected

	def diagonal_change

		puts "\nВ квадратной матрице 10x10 меняет значения элементов в каждой строке, расположенные на главной и побочной диагоналях".yellow
		puts "\nМатрица заполнилась автоматически."
		
		arr = []

		for i in 0..9
			tmp = []
			for j in 0..9
				tmp << rand(0..99)
			end
			arr << tmp
			print "\n #{tmp}"
		end

		puts

		for i in 0..9
			arr[i][i], arr[i][9-i] = arr[i][9-i], arr[i][i]
			print "\n #{arr[i]}"
		end
	end

	def sum_row_col

		puts "\nСчитаем суммы каждой строки и каждого столбца матрицы. Вывести суммы строк в конце каждой строки, а суммы столбцов под соответствующими столбцами.".yellow
		puts "\nВыводим суммы строк в конце каждой строки, а суммы столбцов под соответствующими столбцами.".yellow
		
		puts "\nМатрица заполнилась автоматически."
		
		
		arr     = Array.new(10) { |i| Array.new(10) { |i| rand(0..99) }}
		arr_sum = Array.new(10, 0)

		for i in 0..9
			print "\n #{arr[i]}  +=  #{arr[i].sum}"
			
			for j in 0..9
				arr_sum[j] += arr[i][j]
			end	
		end

		puts
		print "\n #{arr_sum}"
	end	
end

class WorkString < ForMenu

	def initialize
		@title = "Задачи на работу со Строками"
		@menu  = {'1' => "Удалить из строки пробелы и определить, является ли она перевертышем",
						  '2' => "Удаление из строки повторяющихся символов"}
		@prog  = {'1' => "without_spaces",
						  '2' => "without_duplicate",
							'0' => "break"}
	end						

	protected

	def without_spaces

		puts "\nУ введенной строки удаляем все пробелы.".yellow
		puts "После этого определяем, является ли она палиндромом (перевертышем), т.е. одинаково пишется как с начала, так и с конца".yellow

		input_data("Введите строку")

		str = @data.delete(" ")

		puts "Строка без пробелов:  #{str}"

		if str == str.reverse
			puts "Строка является палиндромом"
		else
			puts "Строка НЕ является палиндромом"
		end
	end

	def without_duplicate

		puts "\nУ введенной строки удаляем все повторяющиеся символы и все пробелы.".yellow
		
		input_data("Введите строку")

		str = @data.delete(" ")

		puts "Строка без пробелов:  #{str}"

		arr = str.split('')
		arr.uniq!

		puts "Строка без повторений:  #{arr.join}"
	end	
end

class WorkStruct < ForMenu

	def initialize
		@title = "Задачи на работу с Структурами"
		@menu  = {'1' => "Определить студентов с баллом выше среднего",
						  '2' => "Принадлежит ли дата диапазону времени"}
		@prog  = {'1' => "average_score",
						  '2' => "between_dates",
							'0' => "break"}
	end						

	protected
	
	def average_score

		puts "\nПрограмма определяет средний балл и выводит фамилии и имена студентов, чей балл выше среднего.".yellow

		input_data("Введите количество студентов")

		quantity_student = @data.to_i
		struct_student	 = Hash.new

		arr_up  = [*('A'..'Z')]
		arr_low = [*('a'..'z')]

		puts "\n\nСписок студентов:"

		for i in 1..quantity_student
			stud_name  = arr_up.sample(1) << arr_low.sample(14) << [" "] <<  arr_up.sample(1) << arr_low.sample(5)
			stud_score = rand(1..100)

			struct_student[stud_name.join] = stud_score
			puts "\t#{stud_name.join}  -  #{stud_score}"	
		end

		sum_score = 0

		struct_student.each_value{|val| sum_score += val}

		stud_average_score = sum_score / quantity_student

		puts "Средний бал = #{stud_average_score}"
		puts "Студенты, чей бал выше среднего"


		struct_student.each{|key, val| puts "\t#{key}" if val >= stud_average_score}
	end

	def between_dates

		date1 = {"month" => rand(1..12), "year" => rand(1900..2000)}
		date2 = {"month" => rand(1..12), "year" => rand(2000..2100)}

		puts "\nВ программе заданы месяц и год двух дат:".yellow
		puts "\t#{date1}".yellow
		puts "\t#{date2}".yellow
		puts "Определяем, принадлежит ли третья дата диапазону от первой даты до второй включительно.".yellow
		
		input_data("Введите дату (только месяц и год, через пробел)")

		arr = @data.split(' ').map { |e| e.to_i }

		if date1["year"] < arr[1] and arr[1] < date2["year"]
			puts "\nВведенная дата лежит в диапазоне заданных дат"	 

		elsif date1["year"] == arr[1]
			if date1["month"] <= arr[0]
				puts "\nВведенная дата лежит в диапазоне заданных дат"
			else
				puts "\nВведенная дата НЕ находится в диапазоне заданных дат"
			end

		elsif date2["year"] == arr[1]
			if date2["month"] >= arr[0]
				puts "\nВведенная дата лежит в диапазоне заданных дат"
			else
				puts "\nВведенная дата НЕ находится в диапазоне заданных дат"
			end
		else			
			puts "\nВведенная дата НЕ находится в диапазоне заданных дат"	
		end
	end	
end

class WorkFunction < ForMenu

	def initialize
		@title = "Задачи на работу с Структурами"
		@menu  = {'1' => "Вычислить сумму элементов главной или побочной диагонали матрицы",
						  '2' => "Найти массив с максимальной суммой элементов"}
		@prog  = {'1' => "sum_diagonal",
						  '2' => "max_array",
							'0' => "break"}
	end						

	protected
	
	def sum_diagonal

		puts "\nКвадратная матрица сформирована автоматически.".yellow
		puts "Вычислим сумму элементов главной или побочной диагонали в зависимости от выбора пользователя.".yellow
		
		arr = []

		for i in 0..9
			tmp = []
			for j in 0..9
				tmp << rand(0..99)
			end
			arr << tmp
			print "\n #{tmp}"
		end

		input_data("Выберите, какую диагональ считать \n1 - Главная\n2 - Побочная")

		if @data == "1"
			puts "Сумма элементов главной диагонали  =  #{sum_d(arr, 0)}"
		elsif @data == "2"
			puts "Сумма элементов побочной диагонали  =  #{sum_d(arr, 9)}"
		else
			puts " Введено некорректное значение"
		end				
	end

	def sum_d arr, diag

		sum = 0

		for i in 0..9
			sum += arr[i][(diag-i).abs]
		end
		sum
	end	

	def max_array

		puts "\n10 массивов сформированы автоматически из случайных чисел.".yellow
					
		arr = []

		for i in 0..9
			tmp = create_array(10)
			arr << tmp
			print "\n #{tmp}"
		end

		puts "\n\nВыводим сумму их элементов на экран\n".yellow

		arr_sum     = 0
		arr_max_sum = 0
		arr_max_ind = 0

		arr.each_with_index do |val, ind|
			
			arr_sum = val.sum

			print "\n#{ind + 1}. #{val}  +=  #{arr_sum}"

			if arr_max_sum < arr_sum
				arr_max_ind = ind
				arr_max_sum = arr_sum
			end	
		end 

		puts "\n\nУкажем какой он по счету, повторно вывев этот массив и сумму его элементов.".yellow

		print "\nМассив № #{arr_max_ind + 1}  -  #{arr[arr_max_ind]}  +=  #{arr_max_sum}"
	end	

	def create_array size
		tmp = []
		for j in 0..size-1
			tmp << rand(0..99)
		end
		tmp
	end
end

class WorkFiles < ForMenu

	def initialize	
		@title = "Задачи на работу с Структурами"
		@menu  = {'1' => "Посчитать количество строк в файле и количество слов и символов в каждой строке",
					    '2' => "Найти в файле строки, содержащие определенные значения"}
		@prog  = {'1' => "file_count",
						  '2' => "file_search",
							'0' => "break"}
	end						

	protected
	
	def file_count

		puts "\nВ текстовом файле \"LoremIpsum.txt\" считаем количество строк.".yellow
		puts "А также для каждой отдельной строки определить количество в ней символов и слов".yellow

		file_path = "./LoremIpsum.txt"

		unless File.exist?(file_path)
			puts "Файла #{file_path} нет"
			return
		end	

		file = File.new(file_path,"r")
		file_lines = file.readlines
		
		file_lines.each do |val|
			
			tmp = val.chop
			print tmp
			puts  "  -  в этой строке #{tmp.size} символ(-а) и #{tmp.count(' ')+1} слов(-а)".yellow
		end	

		puts "\nВсего в файле  #{file_lines.size}  строк".yellow

		file.close
	end

	def file_search

		puts "В текстовом файле \"Spisok.txt\" построчно записаны фамилия и имя учащихся класса и его оценка за контрольную.\n".yellow
		
		file_path = "./Spisok.txt"

		unless File.exist?(file_path)
			puts "Файла #{file_path} нет"
			return
		end	

		file = File.new(file_path,"r")
		file_lines = file.readlines

		file_lines.each {|val| print val }

		puts "\nВыводим на экран всех учащихся, чья оценка меньше 3 баллов и считаем средний балл по классу.\n".yellow

		sum_score = 0

		file_lines.each do |val|
			
			val.chop!
			score = val.slice(-1).to_i
			sum_score += score

			puts val if score < 3
							
		end	

		puts "\nСредний бал по списку  =  #{sum_score/file_lines.size}".yellow

		file.close
		
	end	
end

# Main Program
class Controller < ForMenu

	def initialize 
		@title = "Мои программы"
		@menu  = {'1' => "Задачи на Линейные алгоритмы",
						  '2' => "Задачи на Ветвления",
						  '3' => "Задачи на Циклы",
						  '4' => "Задачи на Ветвления",
						  '5' => "Задачи на Вложенные циклы",
						  '6' => "Задачи на Массивы",
						  '7' => "Задачи на Строки",
						  '8' => "Задачи на Структуры данных",
						  '9' => "Задачи на Функции",
						 '10' => "Задачи работу с файлами"}
	end				  

	def run

		while true

		  point = menu_choise
		  
		  case point
		    when '0'
		    	exit
		    when '1'
		    	WorkOperations.new.run
		    when '2'
		    	WorkBranching.new.run
		    when '3'
		     	WorkCycles.new.run
		    when '4'
		    	WorkNestedLoops.new.run
		    when '5'
		     	WorkArray.new.run
		    when '6'
		    	WorkMatrix.new.run
		    when '7'
		    	WorkString.new.run
		    when '8'
		    	WorkStruct.new.run
		    when '9'
		    	WorkFunction.new.run
		    when '10'
		    	WorkFiles.new.run
		  end
		end
	end
end

Controller.new.run