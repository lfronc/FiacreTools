/*
* generated by Xtext
*/
package org.laas.vertics.fiacre.ui.outline

import java.util.HashMap
import java.util.LinkedList
import java.util.List
import org.eclipse.emf.ecore.EObject
import org.eclipse.xtext.ui.editor.outline.IOutlineNode
import org.eclipse.xtext.ui.editor.outline.impl.DefaultOutlineTreeProvider
import org.eclipse.xtext.ui.editor.outline.impl.DocumentRootNode
import org.laas.vertics.fiacre.lang.Profile
import org.laas.vertics.fiacre.lang.AssertDecl
import org.laas.vertics.fiacre.lang.ChannelKind
import org.laas.vertics.fiacre.lang.ChannelTypes
import org.laas.vertics.fiacre.lang.ComponentDecl
import org.laas.vertics.fiacre.lang.ComposableID
import org.laas.vertics.fiacre.lang.ConstDecl
import org.laas.vertics.fiacre.lang.InitPrelude
import org.laas.vertics.fiacre.lang.Instance
import org.laas.vertics.fiacre.lang.Interval
import org.laas.vertics.fiacre.lang.IntervalLeft
import org.laas.vertics.fiacre.lang.IntervalRight
import org.laas.vertics.fiacre.lang.Lang
import org.laas.vertics.fiacre.lang.LocalPortDecl
import org.laas.vertics.fiacre.lang.LocalPortDeclRH
import org.laas.vertics.fiacre.lang.LocalPortDeclarations
import org.laas.vertics.fiacre.lang.LocalPortDecls
import org.laas.vertics.fiacre.lang.LocalVarDecl
import org.laas.vertics.fiacre.lang.LocalVarDeclarations
import org.laas.vertics.fiacre.lang.LocalVarDecls
import org.laas.vertics.fiacre.lang.LoopStmt
import org.laas.vertics.fiacre.lang.Main
import org.laas.vertics.fiacre.lang.NONE
import org.laas.vertics.fiacre.lang.ParComposition
import org.laas.vertics.fiacre.lang.PortDecl
import org.laas.vertics.fiacre.lang.PortDecls
import org.laas.vertics.fiacre.lang.PortName
import org.laas.vertics.fiacre.lang.PortSet
import org.laas.vertics.fiacre.lang.PortSetCompositionBlock
import org.laas.vertics.fiacre.lang.ProcessDecl
import org.laas.vertics.fiacre.lang.PropertyID
import org.laas.vertics.fiacre.lang.SYNC
import org.laas.vertics.fiacre.lang.StarPort
import org.laas.vertics.fiacre.lang.StatesDecl
import org.laas.vertics.fiacre.lang.TagStmt
import org.laas.vertics.fiacre.lang.ToStmt
import org.laas.vertics.fiacre.lang.Transition
import org.laas.vertics.fiacre.lang.TypeArray
import org.laas.vertics.fiacre.lang.TypeBool
import org.laas.vertics.fiacre.lang.TypeDecl
import org.laas.vertics.fiacre.lang.TypeId
import org.laas.vertics.fiacre.lang.TypeIdRef
import org.laas.vertics.fiacre.lang.TypeInt
import org.laas.vertics.fiacre.lang.TypeInterval
import org.laas.vertics.fiacre.lang.TypeNat
import org.laas.vertics.fiacre.lang.TypeQueue
import org.laas.vertics.fiacre.lang.TypeRecord
import org.laas.vertics.fiacre.lang.TypeRecordEntry
import org.laas.vertics.fiacre.lang.TypeUnion
import org.laas.vertics.fiacre.lang.TypeUnionConstr
import org.laas.vertics.fiacre.lang.VarAmp
import org.laas.vertics.fiacre.lang.VarAmps
import org.laas.vertics.fiacre.lang.VarDecl
import org.laas.vertics.fiacre.lang.VarDecls
import org.laas.vertics.fiacre.lang.arguments
import org.laas.vertics.fiacre.lang.assertDeclName
import org.laas.vertics.fiacre.lang.funargument
import org.laas.vertics.fiacre.lang.funarguments
import org.laas.vertics.fiacre.lang.functionDecl
import org.laas.vertics.fiacre.lang.functionName
import org.laas.vertics.fiacre.lang.identsComma
import org.laas.vertics.fiacre.lang.portargs
import org.laas.vertics.fiacre.lang.propertyDecl

/**
 * Customization of the default outline structure.
 *
 * see http://www.eclipse.org/Xtext/documentation.html#outline
 */
class LangOutlineTreeProvider extends DefaultOutlineTreeProvider {
	
	private HashMap<EObject, Integer> mTransNumMap = new HashMap
	private HashMap<EObject, List<EObject>> mTransTagMap = new HashMap
	
	def void _createChildren(DocumentRootNode parentNode, Lang rootElement) {

		// Skip root
		rootElement.getDecl.forEach [ e |
			createNode(parentNode, e)
		]
	}

	def void _createChildren(IOutlineNode parentNode, ConstDecl d) {
	}

	def void _createChildren(IOutlineNode parentNode, InitPrelude modelElement) {
	}

	def void _createChildren(IOutlineNode parentNode, Interval modelElement) {
	}

	def void _createChildren(IOutlineNode parentNode, LocalPortDecl modelElement) {
	}

	def void _createChildren(IOutlineNode parentNode, ToStmt modelElement) {
	}
	
	def void _createChildren(IOutlineNode parentNode, portargs modelElement) {
	}

	def void _createChildren(IOutlineNode parentNode, arguments modelElement) {
	}
	
	def void _createChildren(IOutlineNode parentNode, propertyDecl modelElement) {
	}

	def boolean _isLeaf(TypeArray d) {
		return true
	}

	def boolean _isLeaf(TypeQueue d) {
		return true
	}

	def boolean _isLeaf(AssertDecl d) {
		return true
	}
		
	def boolean _isLeaf(ConstDecl d) {
		return true
	}

	def boolean _isLeaf(TypeInterval i) {
		return true
	}

	def boolean _isLeaf(InitPrelude i) {
		return true
	}

	def boolean _isLeaf(Interval i) {
		return true
	}

	def boolean _isLeaf(LocalPortDecl i) {
		return true
	}

	def boolean _isLeaf(ToStmt s) {
		return true
	}

	def boolean _isLeaf(Instance s) {
		return true
	}

	def boolean _isLeaf(arguments args) {
		return true
	}

	def boolean _isLeaf(portargs args) {
		return true
	}
	
	def boolean _isLeaf(propertyDecl args) {
		return true
	}	

	def void _createNode(IOutlineNode parentNode, PortSet modelElement) {
	}

	def void _createNode(IOutlineNode parentNode, ComposableID modelElement) {
	}

	def void _createNode(IOutlineNode parentNode, TypeUnionConstr modelElement) {
		var String tmp = null
		if (modelElement.getType() != null) {
			tmp = textDispatcher.invoke(modelElement.getType()) as String
		}
		val typeString = tmp
		modelElement.getConstr().forEach [ e |
			var text = textDispatcher.invoke(e)
			if (typeString != null) {
				text = text + " : " + typeString;
			}
			createEObjectNode(parentNode, e, imageDispatcher.invoke(e), text, isLeafDispatcher.invoke(e));
		]
	}

	def static List<Pair<EObject, List<EObject>>> getToStmts(List<EObject> objects) {
			return getToStmts(objects, new LinkedList<EObject>())
	}
	
	def static List<Pair<EObject, List<EObject>>> getToStmts(List<EObject> objects, List<EObject> tags) {
		var l = new LinkedList<Pair<EObject, List<EObject>>>()
		var new_tags = new LinkedList<EObject>()
		new_tags.addAll(tags)
		for (e : objects) {
			switch e {
				TagStmt:
					new_tags.add(e)
				ToStmt, LoopStmt:
					l.add(e -> new_tags)
				default:
					l.addAll(getToStmts(e.eContents,new_tags))
			}
		}
		return l
	}

	def void _createChildren(IOutlineNode parentNode, ProcessDecl modelElement) {
		var i = 0;		
		for (trans : modelElement.trans) {
			var toStmts = getToStmts(trans.statements.eContents)
			for (stmt : toStmts) {			
				mTransNumMap.put(stmt.key, i)				
				i = i + 1;
			}
		}
		super._createChildren(parentNode, modelElement)				
	}

	def void _createChildren(IOutlineNode parentNode, Transition modelElement) {
		var toStmts = getToStmts(modelElement.statements.eContents)
		toStmts.forEach [ p, i |
			val e    = p.key
			val tags = p.value
			val text = textDispatcher.invoke(e) + " (t" + mTransNumMap.get(e) + ")" + tags.map[tag|textDispatcher.invoke(tag)].join(",")			
			mTransTagMap.put(e, tags)
			createEObjectNode(parentNode, e, 
							  imageDispatcher.invoke(e), 
							  text, 
							  isLeafDispatcher.invoke(e)
			);
		]		
	}
		
	def void _createChildren(IOutlineNode parentNode, PortSetCompositionBlock composition) {

		// skip portset
		createNodeDispatcher.invoke(parentNode, composition.body)
	}

	def void _createNode(IOutlineNode parentNode, PortDecl modelElement) {
		var String tmp = null
		if (modelElement.profile != null) {
			tmp = textDispatcher.invoke(modelElement.profile) as String
		}
		val typeString = tmp
		modelElement.port.forEach [ e |
			var text = textDispatcher.invoke(e)
			if (typeString != null) {
				text = text + " : " + typeString;
			}
			createEObjectNode(parentNode, e, imageDispatcher.invoke(e), text, isLeafDispatcher.invoke(e));
		]
	}

	def void _createNode(IOutlineNode parentNode, VarDecl modelElement) {
		val read = if(modelElement.read != null) "read " else ""
		val write = if(modelElement.write != null) "write " else ""
		val type = textDispatcher.invoke(modelElement.type)
		modelElement.amps.amps.forEach [ e |
			var text = textDispatcher.invoke(e) + " : " + read + write + type
			createEObjectNode(parentNode, e, imageDispatcher.invoke(e), text, isLeafDispatcher.invoke(e));
		]
	}

	def void _createNode(IOutlineNode parentNode, LocalVarDecls modelElement) {

		// skip init value here
		modelElement.vars.forEach [ vardecl |
			val type = textDispatcher.invoke(vardecl.type)
			vardecl.idents.names.forEach [ e |
				var text = textDispatcher.invoke(e) + " : " + type
				createEObjectNode(parentNode, e, imageDispatcher.invoke(e), text, isLeafDispatcher.invoke(e));
			]
		]
	}

	def void _createNode(IOutlineNode parentNode, LocalPortDecls modelElement) {

		// skip init value here
		modelElement.ports.forEach [ portdecl |
			val profile = textDispatcher.invoke(portdecl.profile)
			val righthand = if(portdecl.right != null) textDispatcher.invoke(portdecl.right) else ""
			portdecl.idents.names.forEach [ e |
				var text = textDispatcher.invoke(e) + " : " + profile + righthand
				createEObjectNode(parentNode, e, imageDispatcher.invoke(e), text, isLeafDispatcher.invoke(e));
			]
		]
	}

	def void _createNode(IOutlineNode parentNode, TypeRecordEntry modelElement) {
		var String tmp = null
		if (modelElement.getType() != null) {
			tmp = textDispatcher.invoke(modelElement.getType()) as String
		}
		val typeString = tmp
		modelElement.getField().forEach [ e |
			var text = textDispatcher.invoke(e)
			if (typeString != null) {
				text = text + " : " + typeString;
			}
			createEObjectNode(parentNode, e, imageDispatcher.invoke(e), text, isLeafDispatcher.invoke(e));
		]
	}

	def _text(AssertDecl decl) {
		return "assert " + textDispatcher.invoke(decl.getIdent())
	}
	
	def _text(assertDeclName decl) {	
		return decl.ident;
	}
	
	def Object _text(ProcessDecl decl) {
		var ports = ""
		var args = ""
		if (decl.portdecls != null && decl.portdecls.eContents.size > 0) {
			ports = "[" + textDispatcher.invoke(decl.portdecls) + "]"
		}
		if (decl.vardecls != null && decl.vardecls.eContents.size > 0) {
			args = "(" + textDispatcher.invoke(decl.vardecls) + ")"
		}
		return "process " + decl.ident.name + ports + args
	}

	def _text(ComponentDecl decl) {
		var ports = ""
		var args = ""
		if (decl.portdecls != null && decl.portdecls.eContents.size > 0) {
			ports = "[" + textDispatcher.invoke(decl.portdecls) + "]"
		}
		if (decl.vardecls != null && decl.vardecls.eContents.size > 0) {
			args = "(" + textDispatcher.invoke(decl.vardecls) + ")"
		}
		return "component " + decl.ident.name + ports + args
	}

	def _text(TypeDecl decl) {
		return "type " + decl.getName().getName() + " is " + textDispatcher.invoke(decl.getType())
	}

	def _text(ConstDecl decl) {
		return "const " + decl.getName() + " : " + textDispatcher.invoke(decl.getType())
	}

	def _text(TypeUnion union) {
		return "union"
	}

	def _text(TypeRecord record) {
		return "record"
	}

	def _text(TypeInt t) {
		return "int"
	}

	def _text(TypeNat t) {
		return "nat"
	}

	def _text(TypeBool t) {
		return "bool"
	}

	def _text(InitPrelude modelElement) {
		return "init"
	}

	def _text(TypeId id) {
		return "name : " + id.getName()
	}
	
	def _text(propertyDecl decl) {
		return "property " + textDispatcher.invoke(decl.getName()) // + " is LTL"
	}

	def _text(PropertyID id) {
		return id.name
	}
	
	def _text(functionDecl decl) {
		return "function " + textDispatcher.invoke(decl.getName()) 
			+ '(' 
			+ textDispatcher.invoke(decl.args) 
			+ ') : ' + textDispatcher.invoke(decl.rettype) 
	}
	
	def _text(functionName decl) {
		return decl.name
	}
	
	def _text(funarguments args) {
		return args.args.map[e|textDispatcher.invoke(e)].join(", ")
	}
	
	def _text(funargument arg) {
		return textDispatcher.invoke(arg.idenst) + " : " + textDispatcher.invoke(arg.type)
	}
	
	def _text(identsComma idents) {
		return idents.names.map[e|textDispatcher.invoke(e)].join(", ")
	}
	
	def _text(TypeArray arr) {
		val exp = textDispatcher.invoke(arr.getExp())
		val typ = textDispatcher.invoke(arr.getType())
		if (exp != null) {
			return "array " + exp + " of " + typ
		} else {
			return "array of " + textDispatcher.invoke(arr.getType())
		}
	}

	def _text(TypeQueue arr) {
		val exp = textDispatcher.invoke(arr.getExp())
		val typ = textDispatcher.invoke(arr.getType())
		if (exp != null) {
			return "queue " + exp + " of " + typ
		} else {
			return "queue of " + textDispatcher.invoke(arr.getType())
		}
	}

	def _text(TypeIdRef idref) {
		return idref.getName().getName()
	}

	def _text(TypeInterval interval) {
		return 'interval' // interval.getMin() + " .. " + interval.getMax() 
	}

	def _text(PortName port) {
		return port.name
	}

	def _text(Profile prof) {
		val pin = if(prof.pin != null) "IN " else ""
		val pout = if(prof.pout != null) "OUT " else ""
		return pin + pout + textDispatcher.invoke(prof.kind)
	}

	def _text(ChannelKind kind) {
		if (kind.none != null)
			return "none"
		else if (kind.sync != null)
			return "sync"
		else
			return textDispatcher.invoke(kind.types)
	}

	def _text(ChannelTypes types) {
		var list = types.types.map[e|textDispatcher.invoke(e)]
		return list.join("#")
	}

	def _text(SYNC sync) {
		return sync.name
	}

	def _text(NONE sync) {
		return sync.name
	}

	def _text(PortDecl decl) {
		val type = textDispatcher.invoke(decl.profile)
		var list = decl.port.map[p|textDispatcher.invoke(p) + " : " + type]
		return list.join(", ")
	}

	def _text(PortDecls decls) {
		return "ports : " + decls.ports.map[e|textDispatcher.invoke(e)].join(", ")
	}

	def _text(VarDecls decls) {
		var list = decls.vars.map[e|textDispatcher.invoke(e)]
		return "args : " + list.join(", ")
	}

	def _text(LocalVarDeclarations decls) {
		var list = decls.decls.vars.map[e|textDispatcher.invoke(e)]
		return "vars : " + list.join(", ")
	}

	def _text(LocalVarDecl decl) {
		val type = textDispatcher.invoke(decl.type)
		var list = decl.idents.names.map[e|textDispatcher.invoke(e)]
		return list.join(", ") + " : " + type
	}

	def _text(VarDecl decl) {
		var read = if(decl.read != null) "read " else ""
		var write = if(decl.write != null) "write " else ""
		var type = textDispatcher.invoke(decl.type)
		return textDispatcher.invoke(decl.amps) + " : " + read + write + type
	}

	def _text(VarAmps amps) {
		var list = amps.amps.map[e|textDispatcher.invoke(e)]
		return list.join(", ")
	}

	def _text(Transition t) {
		return "from " + t.state.name
	}
	
	def _text(ToStmt to) {
		return "to " + to.state.name
	}

	def _text(TagStmt tag) {
		return "#" + tag.tagName
	}
	
	def _text(VarAmp e) {
		return (if(e.amp != null) "&" else "") + e.name
	}

	def _text(StatesDecl decl) {
		return "states : " + decl.states.map[e|e.name].join(", ")
	}

	def static <T> String join(List<T> l, String sep) {
		var tmp = ""
		var first = true
		for (e : l) {
			if (!first)
				tmp += sep
			if (e != null)
				tmp += e.toString()
			first = false
		}
		return tmp
	}

	def _text(ParComposition composition) {
		return "par" + 
			if (composition.portset != null)
				" " + textDispatcher.invoke(composition.portset) + " in"
			else ""
	}

	def _text(Instance instance) {
		return instance.ident.name + 
			(if (instance.ports != null) textDispatcher.invoke(instance.ports) else "") + 
			(if(instance.args != null) textDispatcher.invoke(instance.args) else "")
	}

	def _text(PortSetCompositionBlock block) {
		return textDispatcher.invoke(block.portset) + " ->"
	}

	def _text(PortSet portset) {
		return portset.ports.join(',')
	}
	def _text(StarPort s) {
		return "*"
	}

	def _text(portargs args) {
		return '[' + args.args.map[e|e.name].join(', ') + ']'
	}
	
	def _text(arguments args) {
		return if (args.eamps.args.empty) "" 
				else "(..)"
	}

	def _text(Interval interval) {
		return textDispatcher.invoke(interval.left) + ', ' + textDispatcher.invoke(interval.right)
	}

	def _text(IntervalLeft left) {
		return left.brack + left.value
	}

	def _text(IntervalRight right) {
		return right.value + right.brack
	}

	def _text(LocalPortDeclarations decls) {
		return textDispatcher.invoke(decls.decls)
	}

	def _text(LocalPortDecls decls) {
		return 'port ' + decls.ports.map[e|textDispatcher.invoke(e)].join(', ')
	}

	def _text(LocalPortDecl decl) {
		return decl.idents.names.map[e|e.name].join(', ') + ' : ' + textDispatcher.invoke(decl.profile) +
			if(decl.right != null) textDispatcher.invoke(decl.right) else ""
	}

	def _text(LocalPortDeclRH rh) {
		return " in " + textDispatcher.invoke(rh.interval) +
			if(rh.probe != null) textDispatcher.invoke(rh.probe) else ""
	}
	
	def _text(LoopStmt l) {
		return "loop"
	}
	
	def _text(Main main) {
		return main.ident.name
	}
}
