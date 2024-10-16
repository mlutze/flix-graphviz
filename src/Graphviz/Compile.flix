mod Graphviz.Compile {
    use Graphviz.Model.Attr
    use Graphviz.Model.AttrTarget
    use Graphviz.Model.Direction
    use Graphviz.Model.Endpoint
    use Graphviz.Model.Graph
    use Graphviz.Model.Id
    use Graphviz.Model.Statement
    use Graphviz.Model.Strictness
    use Graphviz.Model.Subgraph

    use Graphviz.Utils.TwoList

    pub def compile(g: Graph): String = {
        let Graph.Graph(strictness, dir, id, stmts) = g;
        let strictnessString = match strictness {
            case Strictness.Strict => "strict "
            case Strictness.NonStrict => ""
        };
        let graphString = match dir {
            case Direction.Directed => "digraph "
            case Direction.Undirected => "graph "
        };
        let idString = match id {
            case Some(name) => name ++ " "
            case None => ""
        };
        let stmtString =
            List.map(compileStatement(dir), stmts)
            |> List.map(String.indent(4))
            |> List.join("");

        strictnessString ++ graphString ++ idString ++ "{\n"
            ++ stmtString
        ++ "}"
    }

    def compileStatement(dir: Direction, s: Statement): String = match s {
        case Statement.Node(id, attrs) =>
            id ++ " " ++ compileAttributes(attrs)

        case Statement.Edge(points, attrs) =>
            compilePath(dir, points) ++ " " ++ compileAttributes(attrs)

        case Statement.DefaultAttr(target, attrs) =>
            compileAttrTarget(target) ++ " " ++ compileAttributes(attrs)
        
        case Statement.Attr(attr) =>
            compileAttribute(attr)
        
        case Statement.Subgraph(sub) =>
            compileSubgraph(dir, sub)
    }

    def compileId(id: Id): String = {
        id |> String.replace(src = "\\", dst = "\\\\")
            |> String.replace(src = "\"", dst = "\\\"")
    }

    def compileAttributes(ats: List[Attr]): String = {
        let body = ats
            |> List.map(compileAttribute)
            |> List.join(", ");
        "[" ++ body ++ "]"
    }

    def compileAttribute(at: Attr): String = {
        let Attr.Attr(k, v) = at;
        compileId(k) ++ " = " ++ compileId(v)
    }

    def compilePath(d: Direction, p: TwoList[Endpoint]): String = {
        let edgeString = match d {
            case Direction.Directed => " -> "
            case Direction.Undirected => " -- "
        };
        p |> TwoList.toList
            |> List.map(compileEndpoint)
            |> List.join(edgeString)
    }

    def compileEndpoint(e: Endpoint): String = ???

    def compileAttrTarget(t: AttrTarget): String = match t {
        case AttrTarget.Graph => "graph"
        case AttrTarget.Node => "node"
        case AttrTarget.Edge => "edge"
    }

    def compileSubgraph(dir: Direction, g: Subgraph): String = {
        let Subgraph.Subgraph(id, stmts) = g;
        let idString = match id {
            case None => ""
            case Some(name) => name ++ " "
        };
        let stmtString =
            List.map(compileStatement(dir), stmts)
            |> List.map(String.indent(4))
            |> List.join("");
        idString ++ "{\n"
            ++ stmtString
        ++ "}"
    }
}