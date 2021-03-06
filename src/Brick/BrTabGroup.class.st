Class {
	#name : #BrTabGroup,
	#superclass : #BlElement,
	#category : 'Brick-Tabs - UI'
}

{ #category : #'api - adding / removing' }
BrTabGroup >> addTab: anElement [
	self viewModel addTab: anElement viewModel
]

{ #category : #'api - adding / removing' }
BrTabGroup >> addTabs: aCollectionOfElements [
	self viewModel addTabs: (aCollectionOfElements collect: [ :anElement | anElement viewModel])
]

{ #category : #accessing }
BrTabGroup >> content [
	^ self childNamed: #content
]

{ #category : #'api - testing' }
BrTabGroup >> hasTab: anElement [
	^ self viewModel hasTab: anElement viewModel
]

{ #category : #initialization }
BrTabGroup >> initialize [
	super initialize.

	self viewModel: BrTabGroupModel new
]

{ #category : #'api - adding / removing' }
BrTabGroup >> removeTab: anElement [
	self viewModel removeTab: anElement viewModel
]
