~~~python
def firstTournament(tree, i):
    """
    returns the index of the lowest run in this tree
    """
    if i==0:
        return firstTrounament(tree, 1)
    if i*2<len(tree):
        l = firstTournament(tree, i*2)
        r = firstTournament(tree,i*2+1)
        if len(tree[r]) <=0:
            tree[i] = r
            tree[0] = l
            return l
        elif len(tree[l])>0 and tree[l][0]<=tree[r][0]:
            tree[i] = r
            tree[0] = l
            return l
        else:
            tree[i] = l
            tree[0] = r
            return r
    else:
        return i


        
def binaryMerge(runs, dest):
    filledRows = floor(log(len(runs),2))+1
    extraRuns = len(runs) - 2**(filledRows-1)
    extraNodes = extraRuns*2
    tree = [None]*(2**filledRows+extraNodes)
    #initialize tree
    i = len(tree)-1
    while len(tree)-i <= len(runs):
        tree[i] = runs[i-(len(tree)-len(runs))]
        i=i-1
    #debug ('creating tree')
    #debug (tree)
    winner = firstTournament(tree,1)
    #debug ('filling tree initially')
    #debug (tree)
    #debug ('continuing fill')
    while len(tree[winner])>0:
        dest.append(tree[winner].pop(0))
        #debug (tree)
        i = floor(winner/2)
        loser = winner
        while i>0:
            if len(tree[winner])<=0:
                loser = winner
                winner = tree[i]
                tree[i] = loser
            elif len(tree[tree[i]])>0 and tree[tree[i]][0] <= tree[winner][0]:
                loser = winner
                winner = tree[i]
                tree[i] = loser
            #If the winner is still the winner, nothing is to be changed
            tree[0] = winner #for debugging
            i=floor(i/2)
    debug("merge result:")
    debug("\t"+str(dest))
~~~
