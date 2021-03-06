// This file is generated by CodeSmith. Do not edit. All edits to this file will be lost. 
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic;
using System.Linq.Expressions;
using System.Reflection;
using System.Xml.Serialization;

using Indico.DAL;

//namespace Indico.BusinessObjects
namespace Indico.BusinessObjects
{
    /// <summary>
    /// 
    /// </summary>
    public partial class CostSheetImagesBO : BusinessObject, IComparable
    {
        #region fields
        #region Scalar Fields
        private int id;
        private int _costSheet;
        private string _extension;
        private string _filename;
        private int _size;
        #endregion
        
        #region Foreign Key fields
        [NonSerialized][XmlIgnoreAttribute]
        private Indico.BusinessObjects.CostSheetBO _objCostSheet;
        #endregion
        
        #region Foreign Table Foreign Key fields
        #endregion
        
        #region Other fields
        
        private Indico.DAL.CostSheetImages _objDAL = null;
        private bool _doNotUpdateDALObject = false;
        
        #endregion
        
        #endregion
        
        #region Properties
        /// <summary>The Primary Key for this object</summary>
        public int ID
        {   get {return id;}
            set 
            {
                OnIDChanging(value);
                id = value;
                OnIDChanged();
            }
        }
        
        /// <summary>.</summary>
        public int CostSheet
        {   
            get {return _costSheet;}
            set 
            {
                OnCostSheetChanging(value);
                _costSheet = value;
                if (!this._doNotUpdateDALObject && this._context != null && this.ObjDAL != null && ((int)value != 0))
                {
                    this.ObjDAL.CostSheet = (from o in this._context.Context.CostSheet
                                           where o.ID == (int)value
                                           select o).ToList<Indico.DAL.CostSheet>()[0];
                }
                else if (!this._doNotUpdateDALObject && this._context != null && this.ObjDAL != null && (int)value == 0)
                    this.ObjDAL.CostSheet = null;
                OnCostSheetChanged();
            }
        }
        /// <summary>. The maximum length of this property is 10.</summary>
        public string Extension
        {   
            get {return _extension;}
            set 
            {
                OnExtensionChanging(value);
                _extension = value;
                if (!this._doNotUpdateDALObject && this.Context != null && this.ObjDAL != null){
                    this.ObjDAL.Extension = value;
                }
                OnExtensionChanged();
            }
        }
        /// <summary>. The maximum length of this property is 255.</summary>
        public string Filename
        {   
            get {return _filename;}
            set 
            {
                OnFilenameChanging(value);
                _filename = value;
                if (!this._doNotUpdateDALObject && this.Context != null && this.ObjDAL != null){
                    this.ObjDAL.Filename = value;
                }
                OnFilenameChanged();
            }
        }
        /// <summary>.</summary>
        public int Size
        {   
            get {return _size;}
            set 
            {
                OnSizeChanging(value);
                _size = value;
                if (!this._doNotUpdateDALObject && this.Context != null && this.ObjDAL != null){
                    this.ObjDAL.Size = value;
                }
                OnSizeChanged();
            }
        }
        
        internal Indico.DAL.CostSheetImages ObjDAL
        {
            get 
            {
                if (_objDAL == null && base._createDAL)
                {
                    _objDAL = this.SetDAL(this.Context.Context);
                    this.ObjDAL.PropertyChanged += new System.ComponentModel.PropertyChangedEventHandler(obj_PropertyChanged);
                }

                return _objDAL;
            }
            set 
            {
                _objDAL = value;
            }
        }
        
        #endregion
        
        #region Non-scalar Properties
        
        #region Foreign Key Objects
        ///<summary>The CostSheetBO object identified by the value of CostSheet</summary>
        [XmlIgnoreAttribute]
        public Indico.BusinessObjects.CostSheetBO objCostSheet
        {
            get
            {
                if ( _costSheet > 0 && _objCostSheet == null)
                {
                        if (this._context == null)
                        {
                            _objCostSheet = new Indico.BusinessObjects.CostSheetBO();
                        }
                        else
                        {
                            _objCostSheet = new Indico.BusinessObjects.CostSheetBO(ref this._context);
                        }
                        _objCostSheet.ID = _costSheet;
                        _objCostSheet.GetObject(); 
                }
                return _objCostSheet;
            }
            set
            { 
                _objCostSheet = value;
                _costSheet = _objCostSheet.ID;
            }
        }
        #endregion
        
        #region Foreign Object Foreign Key Collections
        #endregion
        
        #endregion
        
        #region Internal Constructors
        /// <summary>
        /// Creates an instance of the CostSheetImagesBO class using the supplied Indico.DAL.CostSheetImages. 
        /// </summary>
        /// <param name="obj">a Indico.DAL.CostSheetImages whose properties will be used to initialise the CostSheetImagesBO</param>
        internal CostSheetImagesBO(Indico.DAL.CostSheetImages obj, ref IndicoContext context)
        {
            this._doNotUpdateDALObject = true;
            
            this.Context = context;
        
            // set the properties from the Indico.DAL.CostSheetImages 
            this.ID = obj.ID;
            
            this.CostSheet = (obj.CostSheetReference.EntityKey != null && obj.CostSheetReference.EntityKey.EntityKeyValues.Count() > 0)
                ? (int)((System.Data.EntityKeyMember)obj.CostSheetReference.EntityKey.EntityKeyValues.GetValue(0)).Value
                : 0;
            this.Extension = obj.Extension;
            this.Filename = obj.Filename;
            this.Size = obj.Size;
            
            this._doNotUpdateDALObject = false;
        }
        #endregion
        
        #region Internal utility methods
        internal Indico.DAL.CostSheetImages SetDAL(IndicoEntities context)
        {
            this._doNotUpdateDALObject = true;
        
            // set the Indico.DAL.CostSheetImages properties
            Indico.DAL.CostSheetImages obj = new Indico.DAL.CostSheetImages();
            
            if (this.ID > 0)
            {
                obj = context.CostSheetImages.FirstOrDefault<CostSheetImages>(o => o.ID == this.ID);
            }
            
            obj.Extension = this.Extension;
            obj.Filename = this.Filename;
            obj.Size = this.Size;
            
            if (this.CostSheet > 0) obj.CostSheet = context.CostSheet.FirstOrDefault(o => o.ID == this.CostSheet);
            
            
            this._doNotUpdateDALObject = false;
            
            return obj;
        }
        
        internal void SetBO(System.Data.Objects.DataClasses.EntityObject eObj)
        {
            this._doNotUpdateDALObject = true;
            
            // Check the received type
            if (eObj.GetType() != typeof(Indico.DAL.CostSheetImages))
            {
                throw new FormatException("Received wrong parameter type...");
            }

            Indico.DAL.CostSheetImages obj = (Indico.DAL.CostSheetImages)eObj;
            
            // set the Indico.BusinessObjects.CostSheetImagesBO properties
            this.ID = obj.ID;
            
            this.Extension = obj.Extension;
            this.Filename = obj.Filename;
            this.Size = obj.Size;
            
            this.CostSheet = (obj.CostSheetReference.EntityKey != null && obj.CostSheetReference.EntityKey.EntityKeyValues.Count() > 0)
                ? (int)((System.Data.EntityKeyMember)obj.CostSheetReference.EntityKey.EntityKeyValues.GetValue(0)).Value
                : 0;
            
            this._doNotUpdateDALObject = false;
        }
        
        internal void SetBO(Indico.BusinessObjects.CostSheetImagesBO obj)
        {
            this._doNotUpdateDALObject = true;
            
            // set this Indico.BusinessObjects.CostSheetImagesBO properties
            this.ID = obj.ID;
            
            this.CostSheet = obj.CostSheet;
            this.Extension = obj.Extension;
            this.Filename = obj.Filename;
            this.Size = obj.Size;
            
            this._doNotUpdateDALObject = false;
        }
        
        internal List<Indico.BusinessObjects.CostSheetImagesBO> IQueryableToList(IQueryable<Indico.DAL.CostSheetImages> oQuery)
        {
            List<Indico.DAL.CostSheetImages> oList = oQuery.ToList();
            List<Indico.BusinessObjects.CostSheetImagesBO> rList = new List<Indico.BusinessObjects.CostSheetImagesBO>(oList.Count);
            foreach (Indico.DAL.CostSheetImages o in oList)
            {
                Indico.BusinessObjects.CostSheetImagesBO obj = new Indico.BusinessObjects.CostSheetImagesBO(o, ref this._context);
                rList.Add(obj);
            }
            return rList;
        }
        
        internal List<Indico.BusinessObjects.CostSheetImagesBO> ToList(IEnumerable<Indico.DAL.CostSheetImages> oQuery)
        {
            List<Indico.DAL.CostSheetImages> oList = oQuery.ToList();
            List<Indico.BusinessObjects.CostSheetImagesBO> rList = new List<Indico.BusinessObjects.CostSheetImagesBO>(oList.Count);
            foreach (Indico.DAL.CostSheetImages o in oList)
            {
                Indico.BusinessObjects.CostSheetImagesBO obj = new Indico.BusinessObjects.CostSheetImagesBO(o, ref this._context);
                rList.Add(obj);
            }
            return rList;
        }
        
        internal static List<Indico.DAL.CostSheetImages> ToEntityList(List<CostSheetImagesBO> bos, IndicoEntities context)
        {
            // build a List of CostSheetImages entities from the business objects
            List<Int32> ids = (from o in bos
                                   select o.ID).ToList<Int32>();

            return (context.CostSheetImages.Count() == 0) ? new List<Indico.DAL.CostSheetImages>() : (context.CostSheetImages.Where(BuildContainsExpression<CostSheetImages, int>(e => e.ID, ids)))
                .ToList<Indico.DAL.CostSheetImages>();
        }
        
        internal static System.Data.Objects.DataClasses.EntityCollection<Indico.DAL.CostSheetImages> ToEntityCollection(List<CostSheetImagesBO> bos, IndicoEntities context)
        {
            // build an EntityCollection of CostSheetImages entities from the business objects
            List<Int32> ids = (from o in bos
                               select o.ID).ToList<Int32>();

            List<Indico.DAL.CostSheetImages> el = (context.CostSheetImages.Count() == 0) ? new List<Indico.DAL.CostSheetImages>() : 
                context.CostSheetImages.Where(BuildContainsExpression<CostSheetImages, int>(e => e.ID, ids))
                .ToList<Indico.DAL.CostSheetImages>();
                
            System.Data.Objects.DataClasses.EntityCollection<Indico.DAL.CostSheetImages> ec 
                = new System.Data.Objects.DataClasses.EntityCollection<Indico.DAL.CostSheetImages>();
                
            foreach (Indico.DAL.CostSheetImages r in el) 
            {
                ec.Add(r);
            }
            return ec;
        }

        internal Indico.DAL.CostSheetImages ToEntity(IndicoEntities context)
        {
            return (from o in context.CostSheetImages
                    where o.ID == this.ID
                    select o).FirstOrDefault();
        }
        #endregion
        
        #region BusinessObject methods
        
        #region Add Object
        
        public void Add()
        {
            if (this.Context != null)
            {
                this.Context.Context.AddToCostSheetImages(this.ObjDAL);
            }
            else
            {
                IndicoContext objContext = new IndicoContext();
                Indico.DAL.CostSheetImages obj = this.SetDAL(objContext.Context);
                objContext.Context.AddToCostSheetImages(obj);
                objContext.SaveChanges();
                objContext.Dispose(); 
            }
        }
        
        #endregion
        
        #region Delete Object
        
        public void Delete()
        {
            if (this.Context != null)
            {
                if (this.ObjDAL != null && this.ObjDAL.EntityKey != null)
                {
                    if (this.ObjDAL.EntityState == System.Data.EntityState.Detached)
                    {
                        this.Context.Context.Attach(this.ObjDAL);
                        this.Context.Context.DeleteObject(this.ObjDAL);
                    }
                    else
                    {
                        this.Context.Context.DeleteObject(this.ObjDAL);
                    }
                }
                else
                {
                    Indico.DAL.CostSheetImages obj = this.SetDAL(this.Context.Context);
                    this.Context.Context.DeleteObject(obj);
                }
            }
            else
            {
                IndicoContext objContext = new IndicoContext();
                Indico.DAL.CostSheetImages obj = this.SetDAL(objContext.Context);
                this.Context.Context.DeleteObject(obj);
                objContext.Context.SaveChanges();
                objContext.Dispose();
            }
        }
        
        #endregion
        
        #region Get Single Object
        
        public bool GetObject()
        {
            return GetObject(true);
        }
        public bool GetObject(bool blnCache)
        {
            Indico.BusinessObjects.CostSheetImagesBO data = null;
            
            if (blnCache)
            {
                data = this.GetFromCache(this.ID) as Indico.BusinessObjects.CostSheetImagesBO; 
            }

            if (data != null)
            {
                SetBO(data);
            }
            else
            {
                try
                {
                    IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
                    IQueryable<Indico.DAL.CostSheetImages> oQuery =
                        from o in context.CostSheetImages
                        where o.ID == this.ID
                        select o;

                    List<Indico.DAL.CostSheetImages> oList = oQuery.ToList();
                    if (oList.Count != 1)
                        return false;
                    else
                    {
                        SetBO(oList[0]);
                        this.Cache();
                    }
                    
                    if (this.Context == null)
                    {
                        context.Dispose();
                    }
                }
                catch (System.Exception e)
                {
                    throw new IndicoException(String.Format(System.Globalization.CultureInfo.InvariantCulture, ResourceManager.GetString("Could not Retrieve a {0} from the data store", System.Globalization.CultureInfo.CurrentCulture), this.ToString()), e, IndicoException.Severities.USER, IndicoException.ERRNO.INT_ERR_BO_SELECT_FAIL);
                }
            }
            return true;
        }
        #endregion
        
        #region GetAllObject
        public List<Indico.BusinessObjects.CostSheetImagesBO> GetAllObject()
        {
            return GetAllObject(0, 0);
        }
        public List<Indico.BusinessObjects.CostSheetImagesBO> GetAllObject(int maximumRows)
        {
            return GetAllObject(maximumRows, 0);
        }
        public List<Indico.BusinessObjects.CostSheetImagesBO> GetAllObject(int maximumRows, int startIndex)
        {
            return GetAllObject(maximumRows, startIndex, null, false);
        }
        public List<Indico.BusinessObjects.CostSheetImagesBO> GetAllObject(int maximumRows, int startIndex, string sortExpression, bool sortDescending)
        {
            IndicoEntities context = new IndicoEntities();
            IQueryable<Indico.DAL.CostSheetImages> oQuery =
                (from o in context.CostSheetImages
                 orderby o.ID
                 select o);

            if (sortExpression != null && sortExpression.Length > 0)
            {
                // using System.Linq.Dynamic here in Dynamic.cs;
                if (sortDescending)
                    oQuery = oQuery.OrderBy(sortExpression + " desc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
                else
                    oQuery = oQuery.OrderBy(sortExpression + " asc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
            }
            else
                oQuery = oQuery.OrderBy(obj => obj.ID).Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);

            List<Indico.BusinessObjects.CostSheetImagesBO> costsheetimagess = IQueryableToList(oQuery);
            context.Dispose();
            return costsheetimagess;
        }
        #endregion
        
        #region SearchObjects
        public List<Indico.BusinessObjects.CostSheetImagesBO> SearchObjects()
        {
            return SearchObjects(0,0);
        }
        public List<Indico.BusinessObjects.CostSheetImagesBO> SearchObjects(int maximumRows)
        {
            return SearchObjects(maximumRows, 0);
        }
        public List<Indico.BusinessObjects.CostSheetImagesBO> SearchObjects(int maximumRows, int startIndex)
        {
            return SearchObjects(maximumRows, startIndex, null, false);
        }
        public List<Indico.BusinessObjects.CostSheetImagesBO> SearchObjects(int maximumRows, int startIndex, string sortExpression, bool sortDescending)
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            IQueryable<Indico.DAL.CostSheetImages> oQuery =
                (from o in context.CostSheetImages
                 where
                    (this.ID == 0 || this.ID == o.ID) &&
                    (this.CostSheet == 0 || this.CostSheet == o.CostSheet.ID) &&
                    (this.Size == 0 || this.Size == o.Size) &&
                    (this.Filename == null || this.Filename == o.Filename) &&
                    (this.Extension == null || this.Extension == o.Extension) 
                 orderby o.ID
                 select o);

            if (sortExpression != null && sortExpression.Length > 0)
            {
                // using System.Linq.Dynamic here in Dynamic.cs;
                if (sortDescending)
                    oQuery = oQuery.OrderBy(sortExpression + " desc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
                else
                    oQuery = oQuery.OrderBy(sortExpression + " asc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
            }
            else
                oQuery = oQuery.OrderBy(obj => obj.ID).Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);

            List<Indico.BusinessObjects.CostSheetImagesBO> costsheetimagess = IQueryableToList(oQuery);
            
            if (this.Context == null)
            {
                context.Dispose();
            }
            
            return costsheetimagess;
        }
        
        public int SearchObjectsCount()
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            return (from o in context.CostSheetImages
                 where
                    (this.ID == 0 || this.ID == o.ID) &&
                    (this.CostSheet == 0 || this.CostSheet == o.CostSheet.ID) &&
                    (this.Size == 0 || this.Size == o.Size) &&
                    (this.Filename == null || this.Filename == o.Filename) &&
                    (this.Extension == null || this.Extension == o.Extension) 
                 orderby o.ID
                 select o).Count();
        }
        #endregion
        
        #region SearchObjectsLikeAnd
        public List<Indico.BusinessObjects.CostSheetImagesBO> SearchLikeAndObjects()
        {
            return SearchLikeAndObjects(0);
        }
        public List<Indico.BusinessObjects.CostSheetImagesBO> SearchLikeAndObjects(int maximumRows)
        {
            return SearchLikeAndObjects(maximumRows, 0);
        }
        public List<Indico.BusinessObjects.CostSheetImagesBO> SearchLikeAndObjects(int maximumRows, int startIndex)
        {
            return SearchLikeAndObjects(maximumRows, startIndex, null, false);
        }
        public List<Indico.BusinessObjects.CostSheetImagesBO> SearchLikeAndObjects(int maximumRows, int startIndex, string sortExpression, bool sortDescending)
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            IQueryable<Indico.DAL.CostSheetImages> oQuery =
                (from o in context.CostSheetImages
                 where
                    (this.ID == 0 || o.ID == this.ID) &&
                    (this.CostSheet == 0 || o.CostSheet.ID == this.CostSheet) &&
                    (this.Size == 0 || o.Size == this.Size) &&
                    (this.Filename == null || o.Filename.Contains(this.Filename)) &&
                    (this.Extension == null || o.Extension.Contains(this.Extension)) 
                 orderby o.ID
                 select o);

            if (sortExpression != null && sortExpression.Length > 0)
            {
                // using System.Linq.Dynamic here in Dynamic.cs;
                if (sortDescending)
                    oQuery = oQuery.OrderBy(sortExpression + " desc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
                else
                    oQuery = oQuery.OrderBy(sortExpression + " asc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
            }
            else
                oQuery = oQuery.OrderBy(obj => obj.ID).Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);

            List<Indico.BusinessObjects.CostSheetImagesBO> costsheetimagess = IQueryableToList(oQuery);
            if (this.Context == null)
            {
                context.Dispose();
            }
            
            return costsheetimagess;
        }
        
        public int SearchLikeAndObjectsCount()
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            return (from o in context.CostSheetImages
                 where
                    (this.ID == 0 || o.ID == this.ID) &&
                    (this.CostSheet == 0 || o.CostSheet.ID == this.CostSheet) &&
                    (this.Size == 0 || o.Size == this.Size) &&
                    (this.Filename == null || o.Filename.Contains(this.Filename)) &&
                    (this.Extension == null || o.Extension.Contains(this.Extension)) 
                 orderby o.ID
                 select o).Count();
            
        }
        #endregion
        
        #region SearchObjectsLikeOr
        public List<Indico.BusinessObjects.CostSheetImagesBO> SearchLikeOrObjects()
        {
            return SearchLikeOrObjects(0);
        }
        public List<Indico.BusinessObjects.CostSheetImagesBO> SearchLikeOrObjects(int maximumRows)
        {
            return SearchLikeOrObjects(maximumRows, 0);
        }
        public List<Indico.BusinessObjects.CostSheetImagesBO> SearchLikeOrObjects(int maximumRows, int startIndex)
        {
            return SearchLikeOrObjects(maximumRows, startIndex, null, false);
        }
        public List<Indico.BusinessObjects.CostSheetImagesBO> SearchLikeOrObjects(int maximumRows, int startIndex, string sortExpression, bool sortDescending)
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            IQueryable<Indico.DAL.CostSheetImages> oQuery =
                (from o in context.CostSheetImages
                 where
                    (this.ID == 0 || this.ID == o.ID) && 
                    (this.CostSheet == 0 || this.CostSheet == o.CostSheet.ID) && 
                    (this.Size == 0 || this.Size == o.Size) && 
                    ((o.Filename.Contains(this.Filename)) ||
                    (o.Extension.Contains(this.Extension)) ||
                    (this.Filename == null && this.Extension == null ))
                 orderby o.ID
                 select o);

            if (sortExpression != null && sortExpression.Length > 0)
            {
                // using System.Linq.Dynamic here in Dynamic.cs;
                if (sortDescending)
                    oQuery = oQuery.OrderBy(sortExpression + " desc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
                else
                    oQuery = oQuery.OrderBy(sortExpression + " asc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
            }
            else
                oQuery = oQuery.OrderBy(obj => obj.ID).Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);

            List<Indico.BusinessObjects.CostSheetImagesBO> costsheetimagess = IQueryableToList(oQuery);
            if (this.Context == null)
            {
                context.Dispose();
            }
            
            return costsheetimagess;
        }
        
        public int SearchLikeOrObjectsCount()
        {
            IndicoEntities context = (this.Context != null) ? this.Context.Context : new IndicoEntities();
            return (from o in context.CostSheetImages
                 where
                    (this.ID == 0 || this.ID == o.ID) && 
                    (this.CostSheet == 0 || this.CostSheet == o.CostSheet.ID) && 
                    (this.Size == 0 || this.Size == o.Size) && 
                    ((o.Filename.Contains(this.Filename)) ||
                    (o.Extension.Contains(this.Extension)) ||
                    (this.Filename == null && this.Extension == null ))
                 orderby o.ID
                 select o).Count();
            
        }
        #endregion
        
        #region Serialization methods
        /// <summary>
        /// Serializes the Indico.BusinessObjects.CostSheetImagesBO to an XML representation
        /// </summary>
        /// <returns>a XML string serialized representation</returns>
        public string SerializeObject()
        {
            string strReturn = "";

            System.IO.MemoryStream objStream = new System.IO.MemoryStream();

            System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(this.GetType());

            x.Serialize(objStream, this);

            System.Text.Encoding encoding = System.Text.Encoding.UTF8;
            // Read string from binary file with UTF8 encoding
            strReturn = encoding.GetString(objStream.GetBuffer());

            objStream.Close();
            return strReturn;

        }

        /// <summary>
        /// Deserializes Indico.BusinessObjects.CostSheetImagesBO object from an XML representation
        /// </summary>
        /// <param name="strXML">a XML string serialized representation</param>
        public Indico.BusinessObjects.CostSheetImagesBO DeserializeObject(string strXML)
        {
            Indico.BusinessObjects.CostSheetImagesBO objTemp = null;
            System.Xml.XmlDocument objXML = new System.Xml.XmlDocument();

            objXML.LoadXml(strXML);
            System.Text.Encoding encoding = System.Text.Encoding.UTF8;

            System.IO.MemoryStream objStream = new System.IO.MemoryStream();
            byte[] b = encoding.GetBytes(objXML.OuterXml);

            objStream.Write(b, 0, (int)b.Length);
            objStream.Position = 0;
            System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(this.GetType());

            objTemp = (Indico.BusinessObjects.CostSheetImagesBO)x.Deserialize(objStream);
            objStream.Close();
            return objTemp;
        }

        /// <summary>
        /// Returns a simple XML representation of Indico.BusinessObjects.CostSheetImagesBO object in an XmlElement
        /// </summary>
        /// <returns>An XML snippet representing the object</returns>
        public string ToXmlString()
        {
            // MW TODO - implement this better.
            return SerializeObject();
        }
        #endregion
        
        #region OnPropertyChange Methods
        partial void OnIDChanged()
        {
            OnCostSheetImagesBOIDChanged();
        }
        
        partial void OnIDChanging(int value)
        {
            if (value < 0)
            {
                throw new Exception(String.Format("CostSheetImagesBO.ID must be more than or equal to 0. The supplied value was {0}.", value));
            }
            OnCostSheetImagesBOIDChanging(value);
        }
        partial void OnIDChanged();
        partial void OnIDChanging(int value);
        partial void OnCostSheetImagesBOIDChanged();
        partial void OnCostSheetImagesBOIDChanging(int value);
        
        partial void OnCostSheetChanged()
        {
            OnCostSheetImagesBOCostSheetChanged();
        }
        
        partial void OnCostSheetChanging(int value)
        {
            if (value < 0)
            {
                throw new Exception(String.Format("CostSheetImagesBO.CostSheet must be more than or equal to 0. The supplied value was {0}.", value));
            }
            OnCostSheetImagesBOCostSheetChanging(value);
        }
        partial void OnCostSheetChanged();
        partial void OnCostSheetChanging(int value);
        partial void OnCostSheetImagesBOCostSheetChanged();
        partial void OnCostSheetImagesBOCostSheetChanging(int value);
        
        partial void OnSizeChanged()
        {
            OnCostSheetImagesBOSizeChanged();
        }
        
        partial void OnSizeChanging(int value)
        {
            OnCostSheetImagesBOSizeChanging(value);
        }
        partial void OnSizeChanged();
        partial void OnSizeChanging(int value);
        partial void OnCostSheetImagesBOSizeChanged();
        partial void OnCostSheetImagesBOSizeChanging(int value);
        
        partial void OnFilenameChanged()
        {
            OnCostSheetImagesBOFilenameChanged();
        }
        
        partial void OnFilenameChanging(string value)
        {
            if (value != null && value.Length > 255)
            {
                throw new Exception(String.Format("CostSheetImagesBO.Filename has a maximum length of 255. The supplied value \"{0}\" has a length of {1}", value, value.Length));
            }
            OnCostSheetImagesBOFilenameChanging(value);
        }
        partial void OnFilenameChanged();
        partial void OnFilenameChanging(string value);
        partial void OnCostSheetImagesBOFilenameChanged();
        partial void OnCostSheetImagesBOFilenameChanging(string value);
        
        partial void OnExtensionChanged()
        {
            OnCostSheetImagesBOExtensionChanged();
        }
        
        partial void OnExtensionChanging(string value)
        {
            if (value != null && value.Length > 10)
            {
                throw new Exception(String.Format("CostSheetImagesBO.Extension has a maximum length of 10. The supplied value \"{0}\" has a length of {1}", value, value.Length));
            }
            OnCostSheetImagesBOExtensionChanging(value);
        }
        partial void OnExtensionChanged();
        partial void OnExtensionChanging(string value);
        partial void OnCostSheetImagesBOExtensionChanged();
        partial void OnCostSheetImagesBOExtensionChanging(string value);
        
        #endregion
        
        #region IComparable Members

        public int CompareTo(object obj)
        {
            if (!(obj is Indico.BusinessObjects.CostSheetImagesBO))
                return 1;
            Indico.BusinessObjects.CostSheetImagesBOComparer c = new Indico.BusinessObjects.CostSheetImagesBOComparer();
            return c.Compare(this, obj as Indico.BusinessObjects.CostSheetImagesBO);
        }

        #endregion
        #endregion
        
        #region Events
        
        void obj_PropertyChanged(object sender, System.ComponentModel.PropertyChangedEventArgs e)
        {
            if (e.PropertyName == "ID")
            {
                // reload me
                this.SetBO((Indico.DAL.CostSheetImages)sender);
            }
        }
        
        void Context_OnSendBeforeChanges(object sender, EventArgs e)
        {        
        }
        
        void Context_OnSendAfterChanges(object sender, EventArgs e)
        {   
            if (this.ID > 0)
            {
                this.Cache();
            }
        }

        #endregion
    }
    
    #region CostSheetImagesBOComparer
    public class CostSheetImagesBOComparer : IComparer<Indico.BusinessObjects.CostSheetImagesBO>
    {
        private string propertyToCompareName;
        public CostSheetImagesBOComparer(string propertyToCompare)
        {
            PropertyInfo p = typeof(Indico.BusinessObjects.CostSheetImagesBO).GetProperty(propertyToCompare);
            if (p == null)
                throw new ArgumentException("is not a public property of Indico.BusinessObjects.CostSheetImagesBO", "propertyToCompare");
            this.propertyToCompareName = propertyToCompare;
        }
        
        public CostSheetImagesBOComparer()
        {
        
        }

        #region IComparer<Indico.BusinessObjects.CostSheetImagesBO> Members
        public int Compare(Indico.BusinessObjects.CostSheetImagesBO x, Indico.BusinessObjects.CostSheetImagesBO y)
        {
            if (propertyToCompareName != null)
            {
                PropertyInfo p = typeof(Indico.BusinessObjects.CostSheetImagesBO).GetProperty(propertyToCompareName);
                return compare(p, x, y);
            }
            else
            {
                PropertyInfo[] arrP = typeof(Indico.BusinessObjects.CostSheetImagesBO).GetProperties();
                foreach (PropertyInfo p in arrP)
                {
                    int v = compare(p, x, y);
                    if (v != 0)
                        return v;
                }
                return 0;
            }
        }

        private int compare(PropertyInfo p, Indico.BusinessObjects.CostSheetImagesBO x, Indico.BusinessObjects.CostSheetImagesBO y)
        {
            object xVal = p.GetValue(x, null);
            object yVal = p.GetValue(y, null);

            if (xVal == null)
            {
                if (yVal == null)
                    return 0;
                else
                    return -1; // x is null, y is not, y is greater
            }
            else
            {
                if (y == null)
                    return 1; // x non null, y is null, x is greater
                else if (xVal is string)
                {
                    return StringComparer.OrdinalIgnoreCase.Compare(xVal, yVal);
                }
                else if (xVal is IComparable)
                {
                    return ((IComparable)xVal).CompareTo((IComparable)yVal);
                }
                else
                    throw new ArgumentException
                        ("is not string or valuetype that implements IComparable", "propertyToCompare");

            }
        }

        #endregion
    }
    #endregion
}
