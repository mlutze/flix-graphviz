mod Graphviz.Model {
    pub enum Strictness {
        case Strict
        case NonStrict
    }

    pub enum Direction {
        case Directed
        case Undirected
    }

    pub type alias Id = String

    pub enum Graph(Strictness, Direction, Option[Id], List[Statement])

    pub enum Statement {
        case Node(Id, List[Attr])
        case Edge(List[Endpoint], List[Attr])
        case DefaultAttr(AttrTarget, List[Attr])
        case Attr(Attr)
        case Subgraph(Subgraph)
    }

    pub enum Endpoint {
        case Node(Id)
        case Subgraph(Subgraph)
    }

    pub enum AttrTarget {
        case Graph
        case Node
        case Edge
    }

    pub enum Attr(Id, Id)

    pub enum Subgraph(Option[Id], List[Statement])
}