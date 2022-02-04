require "libui"
require_relative "solve"

UI = LibUI

$ans = Array.new(9) do
  Array.new(9)
end

$ans = [
  [0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0]
]

def main()
  UI.init

  main_window = UI.new_window("hello world", 400, 800, 0)

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

  ans_label = UI.new_label("結果")
  UI.box_append(hbox, ans_label, 0)

  hox2 = Array.new(9)

  button2 = Array.new(9) do
    Array.new(9)
  end

  j = 0
  while j < 9
    i = 0
    hox2[j] = UI.new_horizontal_box
    #hox2[j]  = UI.new_vertical_box
    while i < 9
      button2[i][j] = UI.new_multiline_entry
      UI.multiline_entry_set_read_only(button2[i][j], 1)
      #button[i][j] = UI.new_label(i.to_s+j.to_s+"  ")
      UI.box_append(hox2[j], button2[i][j], 1)
      i += 1
    end
    UI.box_append(hbox, hox2[j], 1)
    j += 1
  end



  UI.button_on_clicked(action_button) do
    i = 0
    while i < 9
      j = 0
      while j < 9
        if UI.multiline_entry_text(button[i][j]).to_s.empty?
          $ans[i][j] = "0"
        else
          $ans[i][j] = UI.multiline_entry_text(button[i][j]).to_s
        end
        j += 1
      end
      i += 1
    end
    solve()

    j = 0
    while j < 9
      i = 0
      while i < 9
        UI.multiline_entry_set_text(button2[i][j], $ans[i][j])
        i += 1
      end
      j += 1
    end


  end

  UI.control_show(main_window)
  UI.main
  UI.quit
end

main()
