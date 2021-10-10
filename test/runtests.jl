using Test

td = pwd()
for dir in ["basic","hamiltonian_zoo"]
    print("Including Test Dir:",dir,"\n")
    for file in readdir(td*"/"*dir,join=true)
        print("\tIncluding Test File:",file,"\n")
        include(file)
    end
end