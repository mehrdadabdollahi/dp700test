[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Customers_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "CustomerID", DestinationColumnName = "CustomerID"], [SourceColumnName = "FirstName", DestinationColumnName = "FirstName"], [SourceColumnName = "LastName", DestinationColumnName = "LastName"], [SourceColumnName = "Email", DestinationColumnName = "Email"], [SourceColumnName = "City", DestinationColumnName = "City"], [SourceColumnName = "Country", DestinationColumnName = "Country"], [SourceColumnName = "CreatedDate", DestinationColumnName = "CreatedDate"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared Customers = let
  Source = FabricSql.Contents([HierarchicalNavigation = null]),
  #"Navigation 1" = Source{[workspaceId = WSID]}[Data],
  #"Navigation 2" = #"Navigation 1"{[sqlId = SQLID]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Schema = "dbo", Item = "Customers"]}[Data],
  #"Removed columns" = Table.RemoveColumns(#"Navigation 3", {"Sales"})
in
  #"Removed columns";
shared WSID = "99f06a34-4427-4229-b4da-8a314840e6f2" meta [IsParameterQuery = true, IsParameterQueryRequired = false, Type = type text, DefaultValue = ""];
shared SQLID = "2d618ebe-b87e-49a2-bf91-478f511a7cbe" meta [IsParameterQuery = true, IsParameterQueryRequired = false, Type = type text, DefaultValue = ""];
shared Customers_DataDestination = let
  Pattern = Fabric.Warehouse([HierarchicalNavigation = null, CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "82e94661-8a8a-4c22-b855-99b0e068e315"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "72760d56-7355-4042-bfa0-39ea5e71c1dd"]}[Data],
  TableNavigation = Navigation_2{[Item = "Customers", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
