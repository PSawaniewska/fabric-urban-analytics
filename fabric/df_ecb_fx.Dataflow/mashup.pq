[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "ecb_fx_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared ecb_fx = let
  Źródło = Csv.Document(Web.Contents("https://data-api.ecb.europa.eu/service/data/EXR/D.USD.EUR.SP00.A?format=csvdata"), [Delimiter = ",", Columns = 32, QuoteStyle = QuoteStyle.None]),
  #"Nagłówki o podwyższonym poziomie" = Table.PromoteHeaders(Źródło, [PromoteAllScalars = true])
in
  #"Nagłówki o podwyższonym poziomie";
shared ecb_fx_DataDestination = let
  Pattern = Lakehouse.Contents([HierarchicalNavigation = true, EnableVorder = true, OutputMetadataRefresh = true, CreateNavigationProperties = false, EnableFolding = false]),
  Navigation_1 = Pattern{[workspaceId = "48490929-28fc-4758-9f98-c0d64fbc5c71"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "a35f70db-cdc1-4179-8586-93466b0710a0"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "ecb_fx", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
