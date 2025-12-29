# use the officiqal .Net core image as the base image
FROM mcr.microsoft.com/dotnet/sdk:9.0 As build
WORKDIR /mydir
# copy the .csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore
# copy the remaining source code and build the application
COPY . ./
RUN dotnet publish -c Release -o out

# Build the runtime image
FROM mcr.microsoft.com/dotnet/runtime:9.0
WORKDIR /mydir
COPY --from=build /mydir/out .

# Entry point when the container starts
ENTRYPOINT ["dotnet","ConsoleApp1.d11"]
