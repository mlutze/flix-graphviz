mod Graphviz.Utils {
    pub enum TwoList[a](a, a, List[a])

    mod TwoList {
        pub def toList(t: TwoList[a]): List[a] = {
            let TwoList(hd, nk, tl) = t;
            hd :: nk :: tl
        }
    }
}