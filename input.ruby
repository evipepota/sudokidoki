require "libui"
require_relative "solve"

UI = LibUI

$ans = Array.new(9) do
  Array.new(9)
end

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
  action_button = UI.new_button("実行")

  UI.box_append(hbox, problem_label, 0)
  UI.box_append(hbox, action_button, 0)

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

  UI.button_on_clicked(action_button) do
    i = 0
    while i < 9
      j = 0
      while j < 9
        if UI.multiline_entry_text(button[i][j]).to_s.empty?
          $ans[i][j] = 0
        else
          $ans[i][j] = UI.multiline_entry_text(button[i][j]).to_s
        end
        j += 1
      end
      i += 1
    end
    solve
  end

  UI.control_show(main_window)
  UI.main
  UI.quit
end

main()
