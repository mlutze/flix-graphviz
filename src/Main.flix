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

    pub enum Graph(Strictness, Direction, Id, List[Stmt])

    pub enum Stmt {
        case Node
        case Edge
        case Attr
        case Id
        case Subgraph
    }

    pub enum EdgeStmt {
    }
}