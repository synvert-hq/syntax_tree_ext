# CHANGELOG

## 0.4.0 (2023-06-08)

* Add `Syntax::Node#to_hash`

## 0.3.1 (2023-05-18)

* Support `array` in `Node#to_value`

## 0.3.0 (2023-05-15)

* Support `xxx_assoc` to get assoc node of the hash node

## 0.2.0 (2023-05-14)

* Rename `Node#parent` to `Node#parent_node`
* Add `Node#to_value` and `Node#to_source`
* Add `Node#method_missing` for hash `xxx_value` and `xxx_pair`

## 0.1.0 (2023-04-20)

* Add `SyntaxTree::Node#siblings`
* Add `SyntaxTree::Node#source`
