# Getting Started
* Follow the three steps at [https://lean-lang.org/install/] to install VSCode (if you haven't already) and Lean 4.
* If you haven't already, create a GitHub account by going to [https://github.com/] and clicking "Sign Up" in the top right corner.
* Create an SSH key and add it to GitHub. See [https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account] for instructions.
* Run the following terminal commands in order:
```
source ~/.profile
git clone git@github.com:JohnEdwardJennings/lean4dirp.git
cd lean4dirp
lake exe cache get
git checkout -b <your-first-name>
cp Lean4dirp.lean Lean4dirp/Start.lean
git add .
git commit -m "<write your commit message here>"
git push -u origin <your-first-name>
```

From now on, you can edit Lean files by opening the current directory in VSCode, for example by running `code .`.
