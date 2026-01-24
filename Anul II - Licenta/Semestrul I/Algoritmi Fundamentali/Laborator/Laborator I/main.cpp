#include <iostream>
#include <fstream>
#include <vector>

using namespace std;
ifstream f("graf.in");
ofstream g("graf.out");

vector<vector<int> > G, GT;

int n , m , contor , nrs;

vector<bool> V;
vector<int> S;

void read()
{
    f >> n >> m;
    G = GT = vector<vector<int>>(n + 1);
    for(int i = 1 ; i <= m ; i++)
    {
        int a , b;
        f >> a >> b;
        G[a].push_back(b);
        GT[b].push_back(a);
    }

}

void dfs(int k)
{
    V[k] = true;
    for(auto x : G[k])
        if(!V[x])
            dfs(x);
    S.push_back(k);
}

void dfsGT(int k)
{
    V[k]=1;
    cout << k << " ";
    for(auto x: GT[k])
        if(! V[x])
            dfsGT(x);

}

int main()
{
    read();

    V = vector<bool> (n + 1, false);
    for(int i = 0 ; i < n ; i ++)
        if(! V[i]) {
            dfs(i);
        }

    V = vector<bool> (n + 1, false);

    // for(vector<int>::reverse_iterator it = S.rbegin() ; it != S.rend() ; it ++) {
    //     cout << *it << endl;
    // }
    // cout << endl;

    for(vector<int>::reverse_iterator it = S.rbegin() ; it != S.rend() ; it ++)
        if(!V[*it]) {
            contor ++;
            dfsGT(*it);
            cout << endl;
        }

    cout<<contor;
    return 0;
}