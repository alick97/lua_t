function foo()
    return
    print("aaa")
end

function foo1()
    return print("aaa1")
end

function bar1()
    -- `return' is the last statement in the next block
    return
    3
end

function foo2()
    do return end
    print("aab") -- statements not reached
end

foo() -- show aaa, not what you expected
foo1()
foo2()
print(bar1()) -- get 3