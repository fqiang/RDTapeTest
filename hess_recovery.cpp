// basic file operations
#include <iostream>
#include <fstream>
#include <cstdlib>
#include <cassert>
#include <sys/time.h>
#include <vector>
using namespace std;

int findnz(int** bhi, int* lens, int v)
{
  int nz=0;
  for(int i=0;i<v;i++)
  {
    int len = lens[i];
    int* bhii = bhi[i];
    for (int j=0;j<len;j++)
    {
        if (bhii[j] <= v)
        {
            nz++;
        }
    }
  }
  return nz;
}

void structure_recovery_vector(vector<int>& h_I, vector<int>& h_J, int** bhi, int* lens, int v)
{
  // int nz=0;
  for(int i=0;i<v;i++)
  {
    int len = lens[i];
    int* bhii = bhi[i];
    for (int j=0;j<len;j++)
    {
        int v_id = bhii[j];
        if (v_id <= v)
        {
            // nz++;
            if(i>=v_id)
            {
              h_I.push_back(i);
              h_J.push_back(v_id);
            }
            else
            {
              h_I.push_back(v_id);
              h_J.push_back(i);
            }
        }
    }
  }
  // return nz;
}

void structure_recovery_array(int* h_I, int* h_J, int** bhi, int* lens, int v)
{
  int nz=0;
  for(int i=0;i<v;i++)
  {
    int len = lens[i];
    int* bhii = bhi[i];
    for (int j=0;j<len;j++)
    {
        int v_id = bhii[j];
        if (v_id <= v)
        {
            nz++;
            if(i>=v_id)
            {
              h_I[nz] = i;
              h_J[nz] = v_id;
            }
            else
            {
              h_I[nz]= v_id;
              h_J[nz] = i;
            }
        }
    }
  }
}


void hess_recovery(int** bhi,  double** bhv, int* lens, int v, double* hess, double factor)
{
  int nz = 0;
  for(int i=0;i<v;i++)
  {
    int len = lens[i];
    int* bhii = bhi[i];
    double* bhvi = bhv[i];
    for (int j=0;j<len;j++)
    {
        if (bhii[j] <= v)
        {
            hess[nz] = factor*bhvi[j];
            nz ++;
        }
    }
  }
}


int main (int argc, char* argv[]) {
  int v = atoi(argv[1]);
  cout<<"nvar = "<<v<<endl;
  ifstream bhi_len_f;
  ifstream bhi_f;
  bhi_len_f.open("ep_num_edges.txt");
  bhi_f.open ("ep_bhi.txt");
  
  int len;
  int c = 0;
  while(bhi_len_f >> len)
  {
    c++;
  }
  cout<<"c = "<<c<<endl;
  bhi_len_f.clear();
  bhi_len_f.seekg(0,ios::beg);

  int** bhi = new int*[c];
  double** bhv = new double*[c];
  int* lens = new int[c];
  int i = 0;
  while(bhi_len_f >> len)
  {
    bhi[i] = new int[len];
    bhv[i] = new double[len];
    lens[i] = len;
    int idx;
    for(int j=0;j<len;j++)
    {
        bhi_f>>idx;
        bhi[i][j] = idx;
        bhv[i][j] = rand()*10;
    }
    i++;
  }
  cout<<"i = "<<i<<endl;
  bhi_len_f.close();
  bhi_f.close();

  assert(v<c);
  clock_t start = clock();
  int nz = findnz(bhi,lens,v);
  cout << double( clock() - start ) / (double)CLOCKS_PER_SEC<< " findnz seconds." << endl;
  cout<<" nz = "<<nz<<endl;

  start = clock();
  int* h_II = new int[nz];
  int* h_JJ = new int[nz];
  structure_recovery_array(h_II, h_JJ, bhi,lens,v);
  cout << double( clock() - start ) / (double)CLOCKS_PER_SEC<< " structure_recovery_array seconds." << endl;

  vector<int> h_I;
  vector<int> h_J;
  start = clock();
  structure_recovery_vector(h_I, h_J, bhi,lens,v);
  cout << double( clock() - start ) / (double)CLOCKS_PER_SEC<< " structure_recovery_vector seconds." << endl;


  double* hess = new double[nz];  
  double factor = 1.0;
  start = clock();
  hess_recovery(bhi,bhv,lens, v, hess, factor);
  cout << double( clock() - start ) / (double)CLOCKS_PER_SEC<< " hess_recovery seconds." << endl;

  //delete
  for(int i=0;i<c;i++)
  {
    delete[] bhi[i];
    delete[] bhv[i];
  }
  delete[] bhi;
  delete[] bhv;
  delete[] lens;
  delete[] hess;
  delete[] h_II;
  delete[] h_JJ;
  return 0;
}