hooks
onPageAdded: aPageModel
	self
		assert: [ self isAttachedToWidget ]
		description: [ 'I can not receive the page added event without being attached to a widget' ].

	self pages at: aPageModel put: nil.

	aPageModel whenAttachedDo: [ :aPageContentElement |
		| aPageElement |

		aPageContentElement removeFromParent.
		aPageElement := self buildPageElement: aPageContentElement.	
		self pages at: aPageModel put: aPageElement.
	
		pagesListElement dataSource pageElements: self pageElements ]