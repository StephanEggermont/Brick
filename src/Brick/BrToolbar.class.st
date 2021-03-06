Class {
	#name : #BrToolbar,
	#superclass : #BlElement,
	#category : 'Brick-Toolbar - UI'
}

{ #category : #'api - adding / removing' }
BrToolbar >> addItem: anElement [
	self viewModel addItem: anElement viewModel
]

{ #category : #initialization }
BrToolbar >> initialize [
	super initialize.
	self viewModel: BrToolbarModel new.
]

{ #category : #accessing }
BrToolbar >> itemAt: anIndex [
	<return: #BrWidgetModel>

	^ self viewModel itemAt: anIndex
]

{ #category : #accessing }
BrToolbar >> numberOfItems [
	<return: #Integer>
	^ self viewModel numberOfItems
]

{ #category : #'api - adding / removing' }
BrToolbar >> removeItem: anElement [
	self viewModel removeItem: anElement viewModel
]

{ #category : #'api - adding / removing' }
BrToolbar >> removeItemAt: anIndex [
	self viewModel removeItemAt: anIndex
]
