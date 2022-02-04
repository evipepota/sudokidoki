#number = $ans
$solved = 0
$canenter = {}
def init 
    i = 0
    while i < 9
        j = 0
        while j < 9
            $canenter[[i,j]] = []
            $ans[i][j] = $ans[i][j].to_i
            j += 1
        end
        i += 1
    end

end

def enit 
    i = 0
    while i < 9
        j = 0
        while j < 9
            $ans[i][j] = $ans[i][j].to_s
            j += 1
        end
        i += 1
    end

end


def enter(i, j)
    #tate
    $canenter[[i,j]].each do |n|
        hantei = 0
        y = 0
        while y < 9
            if j == y 
                y += 1
                next
            end
            $canenter[[i,y]].each do |n2|
                if $ans[i][y] != 0
                elsif n == n2
                    hantei = 1
                end
            end
            
            y += 1
        end
        if hantei == 0
            $ans[i][j] = n
            $solved += 1
            $canenter[[i,j]] = []
        end
    end

    #yoko
    $canenter[[i,j]].each do |n|
        hantei = 0
        t = 0
        while t < 9
            if i == t
                t += 1
                next
            end
            $canenter[[t,j]].each do |n2|
                if $ans[t][j] != 0
                elsif n == n2
                    hantei = 1
                end
            end
            
            t += 1
        end
        if hantei == 0
            $ans[i][j] = n
            $solved += 1
            $canenter[[i,j]] = []
        end
    end
    
    #square
    $canenter[[i,j]].each do |n|
        hantei = 0
        x = i / 3
        y = j / 3
        ii = 3 * x
        while ii < 3 * x + 3
            jj = 3 * y
            while jj < 3 * y + 3
                if i == ii && j == jj 
                    jj += 1
                    next
                end
                $canenter[[ii,jj]].each do |n2|
                    if $ans[ii][jj] != 0
                    elsif n == n2
                        hantei = 1
                    end
                end
                jj += 1
            end
            ii += 1
        end
        if hantei == 0
            $ans[i][j] = n
            $solved += 1
            $canenter[[i,j]] = []
        end
    end

end

def all_groupe
    i = 0
    while i < 9
        j = 0
        while j < 9
            if $ans[i][j] != 0
                $canenter[[i,j]] = []
                j += 1
                next
            end
            $canenter[[i,j]] = []
            che = Array.new(9,0)
            y = 0
            while y < 9
                if $ans[i][y] == 0
                    y += 1
                    next
                end
                che[$ans[i][y] - 1] = 1 
                y += 1
            end
            t = 0
            while t < 9
                if $ans[t][j] == 0
                    t += 1
                    next
                end
                che[$ans[t][j] - 1] = 1
                t += 1
            end
            x = i / 3
            ii = 3 * x
            while ii < 3 * x + 3
                y = j / 3
                jj = 3 * y
                while jj < 3 * y + 3
                    if $ans[ii][jj] == 0
                        jj += 1
                        next
                    end
                    che[$ans[ii][jj] - 1] = 1
                    jj += 1
                end
                ii += 1
            end
            k = 0
            while k < 9
                if che[k] == 0
                    $canenter[[i,j]] << (k + 1)
                end
                k += 1
            end

            j += 1
        end
        i += 1
    end
end

def solve
    #to do
    #henkou
    init()
    loop do
        $solved = 0
        all_groupe()
        i = 0
        while i< 9
            j = 0
            while j < 9
                if $canenter[[i,j]].length == 1
                    $solved += 1
                    $ans[i][j] = $canenter[[i,j]][0]
                    all_groupe()
                end
                if $ans[i][j] != 0
                    j += 1
                    next
                end
                enter(i,j)
                all_groupe()
                j += 1
            end
            i += 1
        end
        if $solved == 0
            break
        end
    end
    enit()
end
