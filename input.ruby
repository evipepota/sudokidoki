require "libui"

UI = LibUI

def main()
  UI.init

  main_window = UI.new_window("hello world", 500, 500, 0)

  hbox = UI.new_vertical_box
  #hbox = UI.new_horizontal_box
  UI.window_set_child(main_window, hbox)

  UI.window_on_closing(main_window) do
    puts "Close window"
    UI.control_destroy(main_window)
    UI.quit
    0
  end

  problem_label = UI.new_label("問題")
  problem_label = UI.new_button("実行")

  UI.box_append(hbox, problem_label, 0)

  button = Array.new(9) do
    Array.new(9)
  end

  hox = Array.new(9)

  j = 0
  while j < 9
    i = 0
    hox[j] = UI.new_horizontal_box
    #hox[j]  = UI.new_vertical_box
    while i < 9
      button[i][j] = UI.new_multiline_entry
      #button[i][j] = UI.new_label(i.to_s+j.to_s+"  ")
      UI.box_append(hox[j], button[i][j], 1)
      i += 1
    end
    UI.box_append(hbox, hox[j], 0)
    j += 1
  end

  #whilewhileでchangeに送る。
  #i,j,中身を送る。nullのときは0を送る。

  UI.control_show(main_window)
  UI.main
  UI.quit
end

main()

def change
    #なんか配列に送る。
    #配列をsolveに送って全部やる。
end
