#include <iostream>

 namespace ariel{
   struct node
   {
        int data;
        struct node* left;
        struct node* right;
   };
   
   class Tree{
    private:
    
    
    public:
          node *Root;
        Tree();
        void insert(int i);
        void remove (int i);
        int size();
        bool contains(int i);
        int root();
        int parent (int i);
        int left(int i);
        int right(int i);
        void print();
     };
 }
 
